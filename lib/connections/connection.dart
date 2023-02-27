import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sample_bluetooth_serial/main.dart';

class MyHomePage extends HookWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  List<BluetoothDevice> devices = [];

  @override
  Widget build(BuildContext context) {
    final bluetoothEnable = useState(false);
    final bondedDevices = useState([]);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text("BlueTooth Enable"),
              trailing: ElevatedButton(
                onPressed: () async {
                  if (bluetoothEnable.value) return;
                  await FlutterBluetoothSerial.instance.requestEnable();
                  final result = await FlutterBluetoothSerial.instance.state;
                  if (result == BluetoothState.STATE_ON) {
                    bluetoothEnable.value = true;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: bluetoothEnable.value
                      ? Theme.of(context).primaryColor
                      : Colors.redAccent,
                ),
                child: const Icon(Icons.bluetooth),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Bluetooth Status"),
              trailing: ElevatedButton(
                onPressed: () async {
                  await FlutterBluetoothSerial.instance.openSettings();
                },
                child: const Icon(Icons.settings_outlined),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Bonded Devices"),
              trailing: ElevatedButton(
                onPressed: () async {
                  bondedDevices.value =
                      await FlutterBluetoothSerial.instance.getBondedDevices();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: bondedDevices.value.isNotEmpty
                      ? Theme.of(context).primaryColor
                      : Colors.redAccent,
                ),
                child: const Icon(Icons.devices),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Bonded Devices"),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: bondedDevices.value.length,
            itemBuilder: (context, int index) {
              BluetoothDevice device = bondedDevices.value.elementAt(index);
              return Card(
                child: ListTile(
                  title: Text(device.name ?? ""),
                  subtitle: Text(device.address),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      try {
                        BluetoothConnection connection =
                            await BluetoothConnection.toAddress(device.address);

                        if (!connection.isConnected) return;
                        // ignore: use_build_context_synchronously
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConnectDevicePage(
                                      deviceName: device.name ?? "",
                                      bluetoothConnection: connection,
                                    )));

                        if (connection.isConnected) {
                          connection.dispose();
                          print("connection.dispose()");
                        }
                      } catch (exception) {
                        print('Cannot connect, exception occured');
                      }
                    },
                    child: const Text("Connect"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
