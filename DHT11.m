% Load the temperature data
[temp_data, ~] = xlsread('aemz.xlsx', 'Temperature', 'A2:D2407');
time_temp_nonsolar = temp_data(:, 1);
temp_nonsolar = temp_data(:, 2);
time_temp_solar = temp_data(:, 3);
temp_solar = temp_data(:, 4);

% Load the humidity data
[humidity_data, ~] = xlsread('aemz.xlsx', 'Humidity', 'A2:D2407');
time_humidity_nonsolar = humidity_data(:, 1);
humidity_nonsolar = humidity_data(:, 2);
time_humidity_solar = humidity_data(:, 3);
humidity_solar = humidity_data(:, 4);

% Create the figure with two subplots (temperature and humidity)
figure;

% Create the left subplot for temperature
subplot(2, 1, 1); % 2 rows, 1 column, 1st subplot
plot(time_temp_nonsolar, temp_nonsolar, 'b', 'LineWidth', 1.5);
hold on;
plot(time_temp_solar, temp_solar, 'r', 'LineWidth', 1.5);
ylabel('Temperature (°C)');
xlabel('Time (minute)');
legend('Battery-Solar Powered Sensor', 'Battery Powered Sensor');
title('Temperature Reading: Battery Powered Sensor vs Battery-Solar Powered Sensor');
grid on;
hold off;

% Create the right subplot for humidity
subplot(2, 1, 2); % 2 rows, 1 column, 2nd subplot
plot(time_humidity_nonsolar, humidity_nonsolar, 'b', 'LineWidth', 1.5);
hold on;
plot(time_humidity_solar, humidity_solar, 'r', 'LineWidth', 1.5);
ylabel('Humidity (%)');
xlabel('Time (minute)');
legend('Battery-Solar Powered Sensor', 'Battery Powered Sensor');
title('Humidity Reading: Battery Powered Sensor vs Battery-Solar Powered Sensor');
grid on;
hold off;
