#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>

#ifndef STASSID
#define STASSID ".........." // Enter the name of your WiFi Network
#define STAPSK  ".........." // Enter the password of your WiFi Network
#endif

const char* ssid = STASSID;
const char* password = STAPSK;

ESP8266WebServer server(80);

const int led = 13;
// declaring the pin values with which the gadgets to be operated are connected
// const value = 1;

struct gyroscope{
 double rotX;
 double rotY;
 double rotZ;  
};

struct accelometer{
 double accX;
 double accY;
 double accZ;
};

struct accelometer a;
struct gyroscope g;

void workspace(){
  
  
  // Add your code for operating the gadget
  // displayWrite(value, 1); //turning it on
  // displayWrite(value, 0); // turning it off

  // The sensor values can be used with the help of the structs of accelometer and gyrometer define above as a,g;
  // accelometer accX. accY, accZ defines Acceleration force along x,y,z direction respectively including gravity effects.
  // gyroscope rotX, rotY, rotZ define the rate of rotation of sensor about x,y,z axis respectively.

  
}

void handleRoot() {
  digitalWrite(led, 1);
  server.send(200, "text/plain", "hello from esp8266!");
  digitalWrite(led, 0);
}

void handleNotFound() {
  digitalWrite(led, 1);
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET) ? "GET" : "POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i = 0; i < server.args(); i++) {
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }
  server.send(404, "text/plain", message);
  digitalWrite(led, 0);
}

void setup(void) {
  pinMode(led, OUTPUT);
  // setup the pins with which the gadget is connected
  // pinmode(value, OUTPUT);
  
  digitalWrite(led, 0);
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500); 
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  if (MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }

  server.on("/", handleRoot);
  server.on("/post", [](){
    server.send(200, "text/plain", "this works as well");
    updateValue();
    workspace();
  });

  server.on("/on", []() {
    server.send(200, "text/plain", "this works as well");
    ledOn();
  });
  server.on("/off", []() {
    server.send(200, "text/plain", "this works as well");
    ledOff();
  });

  server.onNotFound(handleNotFound);

  pinMode(LED_BUILTIN, OUTPUT);  
  server.begin();
  Serial.println("HTTP server started");
}

void loop(void) {
  server.handleClient();
  MDNS.update();
}

void ledOn(void) {
   digitalWrite(LED_BUILTIN, LOW);   // Turn the LED on (Note that LOW is the voltage level
}
void ledOff(void) {  
  digitalWrite(LED_BUILTIN, HIGH);  // Turn the LED off by making the voltage HIGH         
}

void updateValue(void){
  a.accX = server.arg("accX").toDouble();
  a.accY = server.arg("accY").toDouble();
  a.accZ = server.arg("accZ").toDouble();
  g.rotX = server.arg("rotX").toDouble();
  g.rotY = server.arg("rotY").toDouble();
  g.rotZ = server.arg("rotZ").toDouble();
  Serial.println("accelometer");
  Serial.print("Acceleration X (m/s2): ");
  Serial.println(a.accX);
  Serial.print("Acceleration Y (m/s2): ");
  Serial.println(a.accY);
  Serial.print("Acceleration Z (m/s2): ");
  Serial.println(a.accZ);
  Serial.println("gyroscope");
  Serial.print("Rotation X (rad/s): ");
  Serial.println(g.rotX);
  Serial.print("Rotation Y (rad/s): ");
  Serial.println(g.rotY);
  Serial.print("Rotation Z (rad/s): ");
  Serial.println(g.rotZ);
}
