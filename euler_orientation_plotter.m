% Read CSV file, skipping the first two rows (header and comment)
data = readtable('filter_test_modtorqueplusminus50withoutnewfilter_20250603_175143.csv', 'NumHeaderLines', 2, ...
    'ReadVariableNames', true);

% If headers are not correctly read, manually set variable names
if ~strcmp(data.Properties.VariableNames{1}, 'time')
    data.Properties.VariableNames = {'time', 'pos_x', 'pos_y', 'pos_z', 'vel_x', 'vel_y', 'vel_z', ...
                                     'ori_w', 'ori_i', 'ori_j', 'ori_k', 'des_pos_x', 'des_pos_y', 'des_pos_z', ...
                                     'des_vel_x', 'des_vel_y', 'des_vel_z', 'des_ori_w', 'des_ori_i', 'des_ori_j', ...
                                     'des_ori_k', 'thrust', 'torque_x', 'torque_y', 'torque_z'};
end

% Extract time
time = data.time;

% Extract actual and desired quaternions
actual_quat = [data.ori_w, data.ori_i, data.ori_j, data.ori_k];  % [w, i, j, k]
desired_quat = [data.des_ori_w, data.des_ori_i, data.des_ori_j, data.des_ori_k];  % [w, i, j, k]

% Convert quaternions to Euler angles (XYZ order, in degrees)
actual_euler = quat2eul(actual_quat, 'XYZ') * 180/pi;  % Convert to degrees
desired_euler = quat2eul(desired_quat, 'XYZ') * 180/pi;  % Convert to degrees

% Extract roll (X), pitch (Y), yaw (Z)
actual_roll = actual_euler(:, 1);
actual_pitch = actual_euler(:, 2);
actual_yaw = actual_euler(:, 3);
desired_roll = desired_euler(:, 1);
desired_pitch = desired_euler(:, 2);
desired_yaw = desired_euler(:, 3);

% Create three separate plots for roll, pitch, yaw
figure('Position', [100, 100, 800, 1200]); % Adjust figure size

% Plot Roll (X-axis rotation)
subplot(3, 1, 1);
plot(time, actual_roll, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Roll');
hold on;
plot(time, desired_roll, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Roll');
grid on;
ylabel('Roll (degrees)');
title('Roll (X-axis Rotation): Actual vs Desired');
legend('Location', 'best');
hold off;

% Plot Pitch (Y-axis rotation)
subplot(3, 1, 2);
plot(time, actual_pitch, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Pitch');
hold on;
plot(time, desired_pitch, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Pitch');
grid on;
ylabel('Pitch (degrees)');
title('Pitch (Y-axis Rotation): Actual vs Desired');
legend('Location', 'best');
hold off;

% Plot Yaw (Z-axis rotation)
subplot(3, 1, 3);
plot(time, actual_yaw, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Yaw');
hold on;
plot(time, desired_yaw, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Yaw');
grid on;
xlabel('Time (s)');
ylabel('Yaw (degrees)');
title('Yaw (Z-axis Rotation): Actual vs Desired');
legend('Location', 'best');
hold off;

% Save the figure
saveas(gcf, 'euler_orientations_plots.png');