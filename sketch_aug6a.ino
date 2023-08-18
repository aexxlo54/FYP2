#include <WiFi.h>
#include <HTTPClient.h>
#include <DHT.h> // Include the DHT library

#define analogInPin 34     // Battery voltage measurement pin
#define solarPanelPin 35   // Solar panel voltage measurement pin
#define DHTPIN 23          // DHT11 sensor pin
#define DHTTYPE DHT11      // DHT sensor type

const char *ssid = "Solar";
const char *password = "123456789";
const char *thingspeakApiKey = "NUGZL1V6U1K97AMW";
const int channelId = 2086975;

const char *THINGSPEAK_SERVER = "api.thingspeak.com"; // Define ThingSpeak server address

float calibration = 1.951; // Calibrated calibration factor based on actual voltage readings
float voltage_max = 4.2;
float voltage_min = 3.4;

DHT dht(DHTPIN, DHTTYPE); // Initialize DHT sensor

void setup()
{
  Serial.begin(9600);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

  pinMode(analogInPin, INPUT);

  dht.begin(); // Initialize DHT sensor

  // Wait for a short delay before taking the first reading
  delay(1000);
}

void loop()
{
  // Read battery voltage
  float sensorValue = analogRead(analogInPin);
  float voltage = (sensorValue * 3.3) / 4095 * calibration; // ESP32 ADC is 12-bit (4096 levels)

  // Calculate battery percentage
  int bat_percentage = mapfloat(voltage, 3.4, 4.2, 0, 100); // 3.4V as Battery Cut off Voltage & 4.2V as Maximum Voltage

  if (voltage>voltage_max)
  {
    voltage=voltage_max;
  }

  if (voltage<voltage_min)
  {
    voltage = voltage_min;
  }

  // Ensure battery percentage stays within valid range
  if (bat_percentage >= 100)
  {
    bat_percentage = 100;
  }
  if (bat_percentage <= 0)
  {
    bat_percentage = 1;
  }

  // Read temperature and humidity from DHT11 sensor
  float temperature = dht.readTemperature();
  float humidity = dht.readHumidity();

  // Read solar panel voltage
  float solarPanelValue = analogRead(solarPanelPin);
  float solarVoltage = (solarPanelValue * 3.3) / 4095;

  // Print sensor readings to serial monitor
  Serial.print("Battery Voltage: ");
  Serial.print(voltage, 2);
  Serial.print(" V\tBattery Percentage: ");
  Serial.print(bat_percentage);
  Serial.print(" %\tAnalog Value: ");
  Serial.print(sensorValue);
  Serial.print("\tSolar Panel Voltage: ");
  Serial.print(solarVoltage, 2);
  Serial.print(" V\tTemperature: ");
  Serial.print(temperature, 2);
  Serial.print(" °C\tHumidity: ");
  Serial.print(humidity, 2);
  Serial.print(" %\n");

  // Send data to ThingSpeak
  sendToThingSpeak(voltage, bat_percentage, sensorValue, temperature, humidity, solarVoltage);

  // Wait for a short delay before taking the next reading
  delay(1000);
}

float mapfloat(float x, float in_min, float in_max, float out_min, float out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void sendToThingSpeak(float voltage, int bat_percentage, float analogValue, float temperature, float humidity, float solarVoltage)
{
  WiFiClient client; // Create WiFi client object
  HTTPClient http;   // Create HTTP client object

  String url = "http://";
  url += THINGSPEAK_SERVER;
  url += "/update?api_key=";
  url += thingspeakApiKey;
  url += "&field1=";
  url += String(voltage, 2); // Adding voltage to ThingSpeak with 2 decimal places
  url += "&field2=";
  url += String(bat_percentage);
  url += "&field3=";
  url += String(analogValue);
  url += "&field4=";
  url += String(temperature, 2); // Adding temperature to ThingSpeak with 2 decimal places
  url += "&field5=";
  url += String(humidity, 2);    // Adding humidity to ThingSpeak with 2 decimal places
  url += "&field6=";
  url += String(solarVoltage, 2); // Adding solar voltage to ThingSpeak with 2 decimal places

  http.begin(client, url);
  int httpCode = http.GET();
  Serial.print("HTTP Response Code: ");
  Serial.println(httpCode);

  if (httpCode == HTTP_CODE_OK)
  {
    Serial.println("Data sent to ThingSpeak successfully!");
  }
  else
  {
    Serial.println("Failed to send data to ThingSpeak");
  }

  http.end();
}
