% Read and plot first file
data1_title = "Standard With Noise = 0.05 and Initial Condition (-1.5, -0.25)";
data1 = readtable('Standard_Data/Noise_0.05/Standard_Noise0.05_(-1.5,-0.25).csv');

data2_title = "Standard With Noise = 0.05 and Initial Condition (-1.5, 0.25)";
data2 = readtable('Standard_Data/Noise_0.05/Standard_Noise0.05_(-1.5,0.25).csv');

data3_title = "Standard With Noise = 0.05 and Initial Condition (-1.5, 0)";
data3 = readtable('Standard_Data/Noise_0.05/Standard_Noise0.05_(-1.5,0).csv');


data1 = data1(730:end,:);
actual_pos1 = [data1.pos_x, data1.pos_y, data1.pos_z];
desired_pos1 = [data1.des_pos_x, data1.des_pos_y, data1.des_pos_z];
time1 = data1.time;
[time1, idx1] = unique(time1, 'stable');
actual_pos_2d_1 = actual_pos1(idx1, 1:2);
desired_pos_2d_1 = desired_pos1(idx1, 1:2);

figure;
subplot(1, 3, 1);
plot(actual_pos_2d_1(:,1), actual_pos_2d_1(:,2), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
hold on;
plot(desired_pos_2d_1(:,1), desired_pos_2d_1(:,2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
grid on;
xlabel('X (m)');
ylabel('Y (m)');
title(data1_title);
legend('Location', 'best');
axis([-1.5 1.5 -1.5 1.5]);
hold off;

% Read and plot second file
data2 = data2(730:end,:);
actual_pos2 = [data2.pos_x, data2.pos_y, data2.pos_z];
desired_pos2 = [data2.des_pos_x, data2.des_pos_y, data2.des_pos_z];
time2 = data2.time;
[time2, idx2] = unique(time2, 'stable');
actual_pos_2d_2 = actual_pos2(idx2, 1:2);
desired_pos_2d_2 = desired_pos2(idx2, 1:2);

subplot(1, 3, 2);
plot(actual_pos_2d_2(:,1), actual_pos_2d_2(:,2), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
hold on;
plot(desired_pos_2d_2(:,1), desired_pos_2d_2(:,2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
grid on;
xlabel('X (m)');
ylabel('Y (m)');
title(data2_title);
legend('Location', 'best');
axis([-1.5 1.5 -1.5 1.5]);
hold off;

% Read and plot third file
data3 = data3(730:end,:);
actual_pos3 = [data3.pos_x, data3.pos_y, data3.pos_z];
desired_pos3 = [data3.des_pos_x, data3.des_pos_y, data3.des_pos_z];
time3 = data3.time;
[time3, idx3] = unique(time3, 'stable');
actual_pos_2d_3 = actual_pos3(idx3, 1:2);
desired_pos_2d_3 = desired_pos3(idx3, 1:2);

subplot(1, 3, 3);
plot(actual_pos_2d_3(:,1), actual_pos_2d_3(:,2), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Actual Trajectory');
hold on;
plot(desired_pos_2d_3(:,1), desired_pos_2d_3(:,2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Desired Trajectory');
grid on;
xlabel('X (m)');
ylabel('Y (m)');
title(data3_title);
legend('Location', 'best');
axis([-1.5 1.5 -1.5 1.5]);
hold off;
