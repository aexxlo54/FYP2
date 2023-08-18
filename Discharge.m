% Replace 'C:\Your\Excel\File\Path\' with the actual path to your Excel file
cd('D:\Users\60128\Desktop\HK20 SEM 8\KS40004 PROJECT 2\Result & Analysis')

% Replace 'YourExcelFile.xlsx' with the actual name of your Excel file
% Replace 'A1:F100' with the range of cells containing the data you want to read
[data1807, headers1807] = xlsread('aemz.xlsx', '1807P', 'E2:L84');
[data1907, headers1907] = xlsread('aemz.xlsx', '1907P', 'E2:L76');
[data2307, headers2307] = xlsread('aemz.xlsx', '2307P', 'E2:L139');
[data2707, headers2707] = xlsread('aemz.xlsx', '2707P', 'E2:L89');
[data0408, headers0408] = xlsread('aemz.xlsx', '0408P', 'E2:L283');

dataCombined = vertcat(data1807, data1907,data2307, data2707, data0408);

% Extract X-axis data
DischargeBatteryNonSolar = dataCombined(:, 1);
DischargeBatterywithHarvesting = dataCombined(:, 3);
DischargeBatteryNonSolarTake2 = dataCombined(:, 5);

% Extract Y-axis data
BatteyVoltageNonSolarTake1 = dataCombined(:, 2);
BatteryVoltagewithHarvesting = dataCombined(:, 4);
BatteyVoltageNonSolarTake2 = dataCombined(:, 6);

plot(DischargeBatteryNonSolar, BatteyVoltageNonSolarTake1, 'r.-')
hold on

plot(DischargeBatterywithHarvesting, BatteryVoltagewithHarvesting, 'g.-')
% Plot Non Solar Voltage Take 2
plot(DischargeBatteryNonSolarTake2, BatteyVoltageNonSolarTake2, 'r.-')


xlabel('Discharge Duration for ESP32 Battery (minutes)')
ylabel('Voltage (V)')
legend('Battery Powered Sensor', 'Battery-Solar Powered Sensor', 'Battery Powered Sensor')
title('Battery Voltage Reading vs Discharge Duration')
grid on

