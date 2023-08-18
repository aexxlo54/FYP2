% Replace 'C:\Your\Excel\File\Path\' with the actual path to your Excel file
cd('D:\Users\60128\Desktop\HK20 SEM 8\KS40004 PROJECT 2\Result & Analysis')

% Replace 'YourExcelFile.xlsx' with the actual name of your Excel file
% Replace 'A1:F100' with the range of cells containing the data you want to read
[data1807, headers1807] = xlsread('aemz.xlsx', '1807', 'A2:H551');
% Read data from "1907" sheet
[data1907, headers1907] = xlsread('aemz.xlsx', '1907', 'A2:H672');
[data2307, headers2307] = xlsread('aemz.xlsx', '2307', 'A2:H163');
[data2707, headers2707] = xlsread('aemz.xlsx', '2707', 'A2:H117');
[data0408, headers0408] = xlsread('aemz.xlsx', '0408', 'A2:H1927');

dataCombined = vertcat(data1807, data1907,data2307, data2707, data0408);

% Extract X-axis data
DischargeBatteryNonSolar = dataCombined(:, 1);
DischargeBatterywithHarvesting = dataCombined(:, 3);
DischargeBatteryNonSolarTake2 = dataCombined(:, 5);
DischargeBatterywithHarvestinginRoom = dataCombined(:, 7);

% Extract Y-axis data
BatteyVoltageNonSolarTake1 = dataCombined(:, 2);
BatteryVoltagewithHarvesting = dataCombined(:, 4);
BatteyVoltageNonSolarTake2 = dataCombined(:, 6);
BatteryVoltagewithHarvestinginRoom = dataCombined(:, 8);

% Plot Solar Voltage
plot(DischargeBatterywithHarvesting, BatteryVoltagewithHarvesting, 'g.-')
hold on

plot (DischargeBatterywithHarvestinginRoom, BatteryVoltagewithHarvestinginRoom, 'y.-')

% Plot Non Solar Voltage Take 1
plot(DischargeBatteryNonSolar, BatteyVoltageNonSolarTake1, 'r.-')

% Plot Non Solar Voltage Take 2
plot(DischargeBatteryNonSolarTake2, BatteyVoltageNonSolarTake2, 'r.-')



xlabel('Time (Minute)')
ylabel('Voltage (V)')
legend('Battery-Solar Powered Sensor (Outside) BEST','Battery-Solar Powered Sensor in Room MEDIUM', 'Battery Powered Sensor WORST','Battery Powered Sensor WORST')
title('Battery Lifetime')
grid on

