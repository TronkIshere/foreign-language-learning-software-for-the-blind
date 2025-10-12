#include <Arduino.h>
#include "BluetoothSerial.h"
#include <ArduinoJson.h>
#include <ESP32Servo.h>

BluetoothSerial SerialBT;

const int dotPins[6] = {14, 27, 26, 25, 33, 32};

void setup() {
  Serial.begin(115200);
  Serial.println("=== Test tín hiệu từng chân dotPins ===");

  for (int i = 0; i < 6; i++) {
    pinMode(dotPins[i], OUTPUT);
    digitalWrite(dotPins[i], LOW);
  }
}

void loop() {
  for (int i = 0; i < 6; i++) {
    Serial.printf("🔹 Đang test chân dot%d (GPIO %d)\n", i + 1, dotPins[i]);

    for (int j = 0; j < 6; j++) {
      digitalWrite(dotPins[j], LOW);
    }

    digitalWrite(dotPins[i], HIGH);

    String status = "";
    for (int k = 0; k < 6; k++) {
      status += "dot" + String(k + 1) + "=" + (digitalRead(dotPins[k]) ? "1" : "0");
      if (k < 5) status += " | ";
    }

    Serial.println("👉 Trạng thái: " + status);
    Serial.println("------------------------------");

    delay(1000);
  }

  Serial.println("✅ Hoàn tất một vòng test. Lặp lại sau 2 giây...");
  Serial.println("==============================");
  delay(2000);
}
