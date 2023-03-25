import 'package:flutter/material.dart';

class BoxCircle extends StatefulWidget {
  final String value;
  final List message;
  const BoxCircle({super.key, required this.value, required this.message});

  @override
  State<BoxCircle> createState() => _BoxCircleState();
}

bool isclicked = true;

class _BoxCircleState extends State<BoxCircle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isclicked = !isclicked;
          // print(isclicked);
        });

        print("line = ${widget.message[0]}------------------\n");
        print("col = ${widget.message[1]}------------------\n");
        // print("valueDemander = ${widget.message[2]}------------------\n");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: isclicked ? Colors.white : Color(0xff15233E),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            widget.value,
            style: TextStyle(
              color: isclicked ? Color(0xff15233E) : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
