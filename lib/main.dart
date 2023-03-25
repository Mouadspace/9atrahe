import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'connections/connection.dart';
import 'screnns/base_screen.dart';
import 'screnns/control_screen.dart';
import 'screnns/home.dart';

void main() {
  runApp(const MyApp());
}

List tab = ['0', '.', '8'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,

      // home: MyHomePage(title: '9atrati'), //to connect to bluetooth
      home: BaseScreen(), // ui
    );
  }
}

class ConnectDevicePage extends StatefulWidget {
  final String deviceName;
  final BluetoothConnection bluetoothConnection;

  const ConnectDevicePage(
      {Key? key, required this.deviceName, required this.bluetoothConnection})
      : super(key: key);

  @override
  State<ConnectDevicePage> createState() => _ConnectDevicePageState();
}

class _ConnectDevicePageState extends State<ConnectDevicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceName),
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
                        if (widget.bluetoothConnection.isConnected) {
                          widget.bluetoothConnection.output
                              .add(utf8.encode("1") as Uint8List);
                          await widget.bluetoothConnection.output.allSent;
                        }
                      },
                      child: const Text("1 litre")),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.bluetoothConnection.isConnected) {
                        widget.bluetoothConnection.output
                            .add(utf8.encode("0") as Uint8List);
                        await widget.bluetoothConnection.output.allSent;
                      }
                    },
                    child: const Text("2 litres"),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
            StreamBuilder(
              stream: widget.bluetoothConnection.input,
              builder: (context, snapshot) {
                final String message;
                if (!snapshot.hasData) {
                  message = "All good";
                } else {
                  print(snapshot.data.toString());
                  message = ascii.decode(snapshot.data as List<int>);
                  tab = message.split('.');
                  print(tab);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: tab[0] == '1' ? Colors.red : Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          tab[0] == '1' ? 'Fuite' : "All good",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "${tab[1]} litres",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
