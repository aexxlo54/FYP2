% Replace 'C:\Your\Excel\File\Path\' with the actual path to your Excel file
cd('D:\Users\60128\Desktop\HK20 SEM 8\KS40004 PROJECT 2\Result & Analysis')

% Replace 'YourExcelFile.xlsx' with the actual name of your Excel file
% Replace 'A1:F100' with the range of cells containing the data you want to read
[data, headers] = xlsread('Battery Charge.xlsx', 'Filtered', 'A2:C4587');

% Extract data for left graph (Voltage)
time_solar = data(:, 1);
voltage_solar = data(:, 2);

% Extract data for right graph (Percentage)
time_solar_perc = data(:, 1);
percentage_solar = data(:, 3);

% Create left graph (Voltage)
figure;
yyaxis right;
plot(time_solar, voltage_solar, 'g', 'LineWidth', 1.5);
hold on;
ylabel('Battery Voltage (V)');
xlabel('Time (minutes)');
legend('Solar Voltage');
title(' Charging Duration for Battery-Solar Powered Sensor Device Battery');

% Create right graph (Percentage)
yyaxis left;
plot(time_solar_perc, percentage_solar, 'g--', 'LineWidth', 1.5);
hold on;
ylabel('Battery Percentage (%)');
legend('Battery-Solar Powered Sensor');

% Adjust the layout for better visibility
grid on;
hold off;

