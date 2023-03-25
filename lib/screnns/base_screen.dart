import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sample_bluetooth_serial/screnns/home.dart';

import 'control_screen.dart';
import 'statistics.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    ControlScreen(),
    Statistic(),
  ];

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle = TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.white,
      fontSize: 16,
    );
    return Scaffold(
      body: BaseScreen._widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(26),
          color: Color(0xff15233E),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
          child: GNav(
            backgroundColor: const Color(0xff15233E),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey[900]!,
            gap: 8,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
                textStyle: optionStyle,
              ),
              GButton(
                icon: Icons.miscellaneous_services_outlined,
                text: "Controll",
                textStyle: optionStyle,
              ),
              GButton(
                icon: Icons.stacked_bar_chart_rounded,
                text: "Statistics",
                textStyle: optionStyle,
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
