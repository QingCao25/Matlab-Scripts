% Read CSV file
data = readtable('Final_Data/Circle_Final.csv');

% Extract actual and desired positions
actual_pos = [data.pos_x, data.pos_y, data.pos_z];
desired_pos = [data.des_pos_x, data.des_pos_y, data.des_pos_z];
time = data.time;

% Remove duplicate time points and sort
[time, idx] = unique(time, 'stable'); % Keep first occurrence of duplicates
actual_pos_2d = actual_pos(idx, 1:2); % For 2D plot (x, y)
desired_pos_2d = desired_pos(idx, 1:2); % For 2D plot (x, y)
actual_pos_3d = actual_pos(idx, :); % For 3D plot (x, y, z)
desired_pos_3d = desired_pos(idx, :); % For 3D plot (x, y, z)

% 3D Plot
figure;
plot3(actual_pos_3d(:,1), actual_pos_3d(:,2), actual_pos_3d(:,3), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
hold on;
plot3(desired_pos_3d(:,1), desired_pos_3d(:,2), desired_pos_3d(:,3), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
grid on;
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Quadcopter Trajectory: Actual vs Desired');
legend('Location', 'best');
view(3);
axis([-1 1 -1 1 -1 1]); % Set ±1m limits (2m x 2m x 2m)
hold off;

% 2D Top-Down Plot
figure;
ax = axes;
plot(ax, actual_pos_2d(:,1), actual_pos_2d(:,2), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
hold(ax, 'on');
plot(ax, desired_pos_2d(:,1), desired_pos_2d(:,2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
grid(ax, 'on');
xlabel(ax, 'X (m)');
ylabel(ax, 'Y (m)');
title(ax, 'Quadcopter Trajectory: Actual vs Desired (Top-Down XY)');
legend(ax, 'Location', 'best');
axis(ax, [-1.5 1.5 -1.5 1.5]);
hold(ax, 'off');