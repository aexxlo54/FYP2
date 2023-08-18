% Replace 'C:\Your\Excel\File\Path\' with the actual path to your Excel file
cd('D:\Users\60128\Desktop\HK20 SEM 8\KS40004 PROJECT 2\Result & Analysis')

% Replace 'YourExcelFile.xlsx' with the actual name of your Excel file
% Replace 'A1:F100' with the range of cells containing the data you want to read
[data1807, headers1807] = xlsread('aemz.xlsx', '1807P', 'A2:C551');
[data1907, headers1907] = xlsread('aemz.xlsx', '1907P', 'A2:C672');
[data2307, headers2307] = xlsread('aemz.xlsx', '2307P', 'A2:C163');
[data2707, headers2707] = xlsread('aemz.xlsx', '2707P', 'A2:C117');
[data0408, headers0408] = xlsread('aemz.xlsx', '0408P', 'A2:C1927');

dataCombined = vertcat(data1807, data1907,data2307, data2707, data0408);

% Extract X-axis data
DischargeBatterywithHarvesting = dataCombined(:, 1);

% Extract Y-axis data
SolarVoltagewithHarvestinginRoom = dataCombined(:, 3);
solarVoltagewithHarvesting = dataCombined(:, 2);

plot(DischargeBatterywithHarvesting, solarVoltagewithHarvesting, 'b.-')
hold on

plot(DischargeBatterywithHarvesting, SolarVoltagewithHarvestinginRoom, 'g.-')

xlabel('Solar Panel Voltage Time (minute)')
ylabel('Voltage (V)')
legend('Battery-Solar Powered Sensor (Outside)', 'Battery-Solar Powered Sensor (Room)')
title('Solar Voltage Duration from ESP32 to Recharge Battery')
grid on

