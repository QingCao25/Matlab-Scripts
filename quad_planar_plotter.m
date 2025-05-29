%$ 3D Planar Plot
data = readtable('Good_Circle_20250522_122407.csv');

% Extract actual and desired positions
actual_pos = [data.pos_x, data.pos_y, data.pos_z];
desired_pos = [data.des_pos_x, data.des_pos_y, data.des_pos_z];

% Create 3D plot
figure;
plot3(actual_pos(:,1), actual_pos(:,2), actual_pos(:,3), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
hold on;
plot3(desired_pos(:,1), desired_pos(:,2), desired_pos(:,3), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
grid on;
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Quadcopter Trajectory: Actual vs Desired');
legend('Location', 'best');
view(3);
hold off;

%% 2D Top Down
% Read CSV file
data = readtable('Good_Circle_20250522_122407.csv');

% Extract actual and desired positions
actual_pos = [data.pos_x, data.pos_y];
desired_pos = [data.des_pos_x, data.des_pos_y];
time = data.time;

% Remove duplicate time points and sort
[time, idx] = unique(time, 'stable'); % Keep first occurrence of duplicates
actual_pos = actual_pos(idx, :);
desired_pos = desired_pos(idx, :);

% Create 2D top-down plot
figure;
ax = axes;
plot(ax, actual_pos(:,1), actual_pos(:,2), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
hold(ax, 'on');
plot(ax, desired_pos(:,1), desired_pos(:,2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
grid(ax, 'on');
xlabel(ax, 'X (m)');
ylabel(ax, 'Y (m)');
title(ax, 'Quadcopter Trajectory: Actual vs Desired (Top-Down XY)');
legend(ax, 'Location', 'best');
hold(ax, 'off');