#include <Arduino.h>
#include "BluetoothSerial.h"
#include <ArduinoJson.h>

BluetoothSerial SerialBT;

String readBluetoothJson() {
  if (!SerialBT.available()) return "";
  String input = SerialBT.readStringUntil('\n');
  input.trim();
  return input;
}

String parseBrailleJson(const String &input) {
  StaticJsonDocument<200> doc;
  DeserializationError error = deserializeJson(doc, input);

  if (error) {
    return "❌ JSON parse failed: " + String(error.c_str());
  }

  String status = "";
  for (int i = 1; i <= 6; i++) {
    String key = "dot" + String(i);
    if (doc.containsKey(key)) {
      status += key + "=" + String(doc[key].as<bool>() ? "1" : "0");
    } else {
      status += key + "=x";
    }
    if (i < 6) status += " | ";
  }
  return status;
}

void printBrailleStatus(const String &input) {
  if (input.isEmpty()) return;

  Serial.println("📩 Received raw: " + input);
  String status = parseBrailleJson(input);
  Serial.println("👉 Braille State: " + status);
  Serial.println("------------------------------");
}

void setup() {
  Serial.begin(115200);

  if (!SerialBT.begin("ESP32-Braille", false)) {  
    Serial.println("⚠️ Bluetooth init failed!");
    while (true);
  }
  Serial.println("✅ ESP32 Bluetooth started, waiting for connection...");
}

void loop() {
  if (SerialBT.hasClient()) {
    String jsonInput = readBluetoothJson();
    printBrailleStatus(jsonInput);
  } else {
    static unsigned long lastPrint = 0;
    if (millis() - lastPrint > 5000) {
      Serial.println("⌛ Waiting for a Bluetooth client to connect...");
      lastPrint = millis();
    }
  }
}
