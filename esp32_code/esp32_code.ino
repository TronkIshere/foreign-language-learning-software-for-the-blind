#include <Arduino.h>
#include "BluetoothSerial.h"
#include <ArduinoJson.h>

BluetoothSerial SerialBT;

const int dotPins[6] = {14, 27, 26, 25, 33, 32};

String readBluetoothJson() {
  if (!SerialBT.available()) return "";
  String input = SerialBT.readStringUntil('\n');
  input.trim();
  return input;
}

void applyBraillePins(const String &input) {
  if (input.isEmpty()) return;

  StaticJsonDocument<200> doc;
  DeserializationError error = deserializeJson(doc, input);

  if (error) {
    Serial.println("❌ JSON parse failed: " + String(error.c_str()));
    return;
  }

  for (int i = 0; i < 6; i++) {
    digitalWrite(dotPins[i], LOW);
  }

  String status = "";
  for (int i = 0; i < 6; i++) {
    String key = "dot" + String(i + 1);
    if (doc.containsKey(key)) {
      bool value = doc[key].as<bool>();
      digitalWrite(dotPins[i], value ? HIGH : LOW);   
      status += key + "=" + (value ? String("1") : String("0"));
    } else {
      status += key + "=x";
    }
    if (i < 5) status += " | ";
  }

  Serial.println("👉 Braille State: " + status);
  Serial.println("------------------------------");
}

void setup() {
  Serial.begin(115200);

  for (int i = 0; i < 6; i++) {
    pinMode(dotPins[i], OUTPUT);
    digitalWrite(dotPins[i], LOW); 
  }

  if (!SerialBT.begin("ESP32-Braille", false)) {  
    Serial.println("⚠️ Bluetooth init failed!");
    while (true);
  }
  Serial.println("✅ ESP32 Bluetooth started, waiting for connection...");
}

void loop() {
  if (SerialBT.hasClient()) {
    String jsonInput = readBluetoothJson();
    if (!jsonInput.isEmpty()) {
      Serial.println("📩 Received raw: " + jsonInput);
      applyBraillePins(jsonInput);
    }
  } else {
    static unsigned long lastPrint = 0;
    if (millis() - lastPrint > 5000) {
      Serial.println("⌛ Waiting for a Bluetooth client to connect...");
      lastPrint = millis();
    }
  }
}
