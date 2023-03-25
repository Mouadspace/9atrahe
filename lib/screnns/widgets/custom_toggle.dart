import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final void Function(bool isToggled) onToggled;

  const CustomToggle({Key? key, required this.onToggled}) : super(key: key);

  @override
  State<CustomToggle> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<CustomToggle> {
  bool isToggled = false;
  double size = 30;
  double innerPadding = 0;

  @override
  void initState() {
    innerPadding = size / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 18),
        child: AnimatedContainer(
          height: 32.5,
          width: 55,
          padding: EdgeInsets.all(innerPadding),
          alignment: isToggled ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isToggled ? const Color(0xff8CD7FE) : Colors.grey.shade300,
          ),
          child: Container(
            width: 27.5,
            height: 27.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: isToggled ? const Color(0xffE8F5E9) : Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
