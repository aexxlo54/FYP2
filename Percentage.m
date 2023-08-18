% Replace 'C:\Your\Excel\File\Path\' with the actual path to your Excel file
cd('D:\Users\60128\Desktop\HK20 SEM 8\KS40004 PROJECT 2\Result & Analysis')

% Replace 'YourExcelFile.xlsx' with the actual name of your Excel file
% Replace 'A1:F100' with the range of cells containing the data you want to read
[data, headers] = xlsread('aemz.xlsx', '1807', 'A2:L551');

% Extract data for left graph (Voltage)
time_non_solar_take1 = data(:, 1);
voltage_non_solar_take1 = data(:, 2);
time_solar = data(:, 3);
voltage_solar = data(:, 4);
time_non_solar_take2 = data(:, 5);
voltage_non_solar_take2 = data(:, 6);

% Extract data for right graph (Percentage)
time_non_solar_take1_perc = data(:, 1);
percentage_non_solar_take1 = data(:, 10);
time_solar_perc = data(:, 3);
percentage_solar = data(:, 11);
time_non_solar_take2_perc = data(:, 5);
percentage_non_solar_take2 = data(:, 12);

% Create left graph (Voltage)
figure;
yyaxis right;
plot(time_solar, voltage_solar, 'g', 'LineWidth', 1.5);
hold on;
plot(time_non_solar_take1, voltage_non_solar_take1, 'r', 'LineWidth', 1.5);
plot(time_non_solar_take2, voltage_non_solar_take2, 'r', 'LineWidth', 1.5);
ylabel('Battery Voltage (V)');
xlabel('Time (Minute)');
legend('Battery-Solar Powered Sensor','Battery Powered Sensor', 'Battery Powered Sensor');
title('Battery Voltage (V) & Battery Percentage (%) Comparison');

% Create right graph (Percentage)
yyaxis left;
plot(time_solar_perc, percentage_solar, 'g--', 'LineWidth', 1.5);
hold on;
plot(time_non_solar_take1_perc, percentage_non_solar_take1, 'r--', 'LineWidth', 1.5);
plot(time_non_solar_take2_perc, percentage_non_solar_take2, 'r--', 'LineWidth', 1.5);
ylabel('Battery Percentage (%)');
legend('Battery-Solar Powered Sensor', 'Battery Powered Sensor', 'Battery Powered Sensor');

% Adjust the layout for better visibility
grid on;
hold off;

