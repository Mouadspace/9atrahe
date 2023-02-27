import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Bluetooth Serial Demo'),
    );
  }
}

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

class ConnectDevicePage extends StatelessWidget {
  final String deviceName;
  final BluetoothConnection bluetoothConnection;

  const ConnectDevicePage(
      {Key? key, required this.deviceName, required this.bluetoothConnection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deviceName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (bluetoothConnection.isConnected) {
                        bluetoothConnection.output
                            .add(utf8.encode("1") as Uint8List);
                        await bluetoothConnection.output.allSent;
                      }
                    },
                    child: const Icon(
                      Icons.flashlight_on_outlined,
                      size: 64.0,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (bluetoothConnection.isConnected) {
                        bluetoothConnection.output
                            .add(utf8.encode("0") as Uint8List);
                        await bluetoothConnection.output.allSent;
                      }
                    },
                    child: const Icon(
                      Icons.flashlight_off_outlined,
                      size: 64.0,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
            StreamBuilder(
              stream: bluetoothConnection.input,
              builder: (context, snapshot) {
                final String message;
                if (!snapshot.hasData) {
                  message = "<<";
                } else {
                  print(snapshot.data.toString());
                  message = ascii.decode(snapshot.data as List<int>);
                }
                return Container(
                  width: 350,
                  height: 400,
                  color: Colors.black,
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
