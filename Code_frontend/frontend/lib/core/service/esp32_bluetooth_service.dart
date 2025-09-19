import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial_plus/flutter_bluetooth_serial_plus.dart';

class Esp32BluetoothService {
  final String deviceName = "ESP32-Braille";
  BluetoothDevice? connectedDevice;
  BluetoothConnection? connection;

  Future<void> connect() async {
    try {
      List<BluetoothDevice> bondedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();

      connectedDevice = bondedDevices.firstWhere(
        (d) => d.name == deviceName,
        orElse: () => throw Exception("Không tìm thấy thiết bị $deviceName"),
      );

      connection = await BluetoothConnection.toAddress(connectedDevice!.address);

      print("✅ Đã kết nối đến ${connectedDevice!.name}");
    } catch (e) {
      print("❌ Không kết nối được ESP32-Braille: $e");
    }
  }

  Future<void> sendBraille(Map<String, bool> dots) async {
    if (connection != null && connection!.isConnected) {
      final jsonData = json.encode(dots) + "\n";
      connection!.output.add(Uint8List.fromList(utf8.encode(jsonData)));
      await connection!.output.allSent;
      print("📤 Đã gửi: $jsonData");
    } else {
      print("⚠️ Chưa kết nối, không thể gửi dữ liệu");
    }
  }

  Future<void> disconnect() async {
    await connection?.close();
    connectedDevice = null;
    connection = null;
    print("🔌 Đã ngắt kết nối ESP32");
  }
}
