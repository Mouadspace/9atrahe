import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final double transaleX, translateY;
  const Background({
    super.key,
    required this.transaleX,
    required this.translateY,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: transaleX,
      top: translateY,
      child: Container(
        width: 750,
        height: 750,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff61C2FF), Color(0xffD4F4FE)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff9CD4F8),
              spreadRadius: 2,
              blurRadius: 72,
              offset: Offset(7, 49),
            )
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
