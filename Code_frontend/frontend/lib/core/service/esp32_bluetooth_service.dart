import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Esp32BluetoothService {
  final String deviceName = "ESP32-Braille";
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? writeCharacteristic;

  Future<void> connect() async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    try {
      var results = await FlutterBluePlus.scanResults.firstWhere(
        (devices) => devices.any((r) => r.device.name == deviceName),
      );
      await FlutterBluePlus.stopScan();

      var result = results.firstWhere((r) => r.device.name == deviceName);
      connectedDevice = result.device;

      await connectedDevice!.connect();

      var services = await connectedDevice!.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.write) {
            writeCharacteristic = characteristic;
            print("Đã tìm thấy writeCharacteristic");
            return;
          }
        }
      }
      print("Không tìm thấy writeCharacteristic");
    } catch (e) {
      print("Không kết nối được ESP32-Braille: $e");
    }
  }

  Future<void> sendBraille(Map<String, bool> dots) async {
    if (writeCharacteristic == null) {
      return;
    }
    final jsonData = json.encode(dots);
    await writeCharacteristic!.write(utf8.encode(jsonData));
  }

  Future<void> disconnect() async {
    await connectedDevice?.disconnect();
    connectedDevice = null;
    writeCharacteristic = null;
  }
}
