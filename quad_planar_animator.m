% Read CSV file
data = readtable('Final_Data/Circle_Final.csv');

% Extract actual and desired positions
actual_pos = [data.pos_x, data.pos_y, data.pos_z];
desired_pos = [data.des_pos_x, data.des_pos_y, data.des_pos_z];
time = data.time;

% Remove duplicate time points and sort
[time, idx] = unique(time, 'stable'); % Keep first occurrence of duplicates
actual_pos = actual_pos(idx, :); % Update corresponding positions
desired_pos = desired_pos(idx, :);

% Interpolate data for smoother animation
interp_factor = 5; % Adjust for smoothness
t_fine = linspace(time(1), time(end), length(time)*interp_factor);
actual_pos_fine = interp1(time, actual_pos, t_fine, 'linear');
desired_pos_fine = interp1(time, desired_pos, t_fine, 'linear');

% Initialize figure and axes
fig = figure;
ax = axes('Parent', fig);
axis(ax, [-2 2 -2 2 -2 2]);
hold(ax, 'on');
grid(ax, 'on');
xlabel(ax, 'X (m)');
ylabel(ax, 'Y (m)');
zlabel(ax, 'Z (m)');
title(ax, 'Quadcopter Flight Animation: Actual vs Desired');
view(ax, 3);

% ✅ True 3D sphere at the origin (not warped)
[rs, cs, zs] = sphere(30); % Resolution of the sphere
radius = 0.75;            % 0.75 m diameter / 2
surf(ax, radius * rs, radius * cs, radius * zs, ...
     'FaceAlpha', 0.3, 'EdgeColor', 'none', 'FaceColor', 'g', ...
     'DisplayName', 'Fixed Sphere at Origin');

% Initialize plots
h1 = plot3(ax, actual_pos_fine(1,1), actual_pos_fine(1,2), actual_pos_fine(1,3), 'bo', 'MarkerSize', 8, 'DisplayName', 'Actual Position');
h2 = plot3(ax, desired_pos_fine(1,1), desired_pos_fine(1,2), desired_pos_fine(1,3), 'ro', 'MarkerSize', 8, 'DisplayName', 'Desired Position');
h3 = plot3(ax, actual_pos_fine(1:1,1), actual_pos_fine(1:1,2), actual_pos_fine(1:1,3), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
h4 = plot3(ax, desired_pos_fine(1:1,1), desired_pos_fine(1:1,2), desired_pos_fine(1:1,3), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
legend(ax, 'Location', 'best');

% Animation loop
for i = 2:length(t_fine)
    % Check if figure is still open
    if ~isvalid(fig)
        warning('Figure closed, stopping animation.');
        break;
    end
    
    % Update actual position marker
    set(h1, 'XData', actual_pos_fine(i,1), 'YData', actual_pos_fine(i,2), 'ZData', actual_pos_fine(i,3));
    
    % Update desired position marker
    set(h2, 'XData', desired_pos_fine(i,1), 'YData', desired_pos_fine(i,2), 'ZData', desired_pos_fine(i,3));
    
    % Update trajectories
    set(h3, 'XData', actual_pos_fine(1:i,1), 'YData', actual_pos_fine(1:i,2), 'ZData', actual_pos_fine(1:i,3));
    set(h4, 'XData', desired_pos_fine(1:i,1), 'YData', desired_pos_fine(1:i,2), 'ZData', desired_pos_fine(1:i,3));
    
    % Fast rendering
    drawnow limitrate;
end
hold(ax, 'off');
