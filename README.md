# IOT-Android
The project is aimed at minimising the hardware requirements of IOT Projects by making use of our phone as sensor. In this project the code is provided for obtaining the accelometer and gyroscope sensor data from the phone to the arduino wirelessly.

# Requirements

1. Arduino ESP8266 WiFi Module.
2. Android Phone as Sensor.

# Procedure for using the Phone as sensor.

1. Make a new file in the Arduino IDE and add the Web-Server.Ink.ino file code present in the Web-Server.Ink folder into it.
2. Type in the WiFi name and password into the variables as stated in the code.
3. Install the code on the Arduino Module and open the Serial Monitor. 
4. Hard Reset the Arduino Module and obtain the IP Address of the Arduino Module as printed in the Serial Monitor.
5. Install the app-release.apk file on your android device and add the IP Address in the form page that appears on opening the App in the      format:
      http://192.168.100.24  .
6. Now the phone is connected to the Arduino Module and is providing the sensor values.
7. Add your code for monitoring your gadget based on sensor values into the workspace function of the arduino code. The Information for using the sensor values is provided in the workspace function itself.
8. Install the code on your Arduino Module and use the phone as the sensor for monitoring your gadget.

# Important
  Make sure that the phone and Arduino are connected to the same WiFi

