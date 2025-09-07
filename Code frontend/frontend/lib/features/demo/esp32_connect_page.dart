import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Esp32ConnectPage extends StatefulWidget {
  const Esp32ConnectPage({super.key});

  @override
  State<Esp32ConnectPage> createState() => _Esp32ConnectPageState();
}

class _Esp32ConnectPageState extends State<Esp32ConnectPage> {
  BluetoothDevice? esp32Device;
  bool isScanning = false;

  final String targetDeviceName = "ESP32_BLE_DEVICE";
  final String? targetMac = null;

  Future<void> checkAndRequestPermissions() async {
    if (await Permission.bluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }
    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  void startScanAndConnect() async {
    await checkAndRequestPermissions();

    setState(() => isScanning = true);

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) async {
      for (var r in results) {
        final device = r.device;
        if (device.platformName == targetDeviceName ||
            (targetMac != null && device.remoteId.toString().toUpperCase() == targetMac!.toUpperCase())) {
          await FlutterBluePlus.stopScan();
          connectToEsp32(device);
          break;
        }
      }
    });

    FlutterBluePlus.isScanning.listen((scanning) {
      setState(() => isScanning = scanning);
    });
  }

  Future<void> connectToEsp32(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      setState(() {
        esp32Device = device;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã kết nối ESP32: ${device.platformName}")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lỗi kết nối: $e")));
      }
    }
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    esp32Device?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kết nối ESP32")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (esp32Device != null)
              Text(
                "Đã kết nối với: ${esp32Device!.platformName}",
                style: const TextStyle(fontSize: 18, color: Colors.green),
              )
            else
              ElevatedButton(
                onPressed: isScanning ? null : startScanAndConnect,
                child: Text(isScanning ? "Đang quét..." : "Kết nối ESP32"),
              ),
          ],
        ),
      ),
    );
  }
}
