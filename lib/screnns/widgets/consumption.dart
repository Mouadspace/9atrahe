import 'package:flutter/material.dart';

class Consumption extends StatefulWidget {
  const Consumption({
    super.key,
  });

  @override
  State<Consumption> createState() => _ConsumptionState();
}

class _ConsumptionState extends State<Consumption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 34, top: 43),
      child: const Text.rich(
          textAlign: TextAlign.left,
          TextSpan(children: [
            TextSpan(
              text: "98",
              style: TextStyle(
                color: Color(0xff15233E),
                fontSize: 120,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              text: " litres\n",
              style: TextStyle(
                color: Color(0xff15233e),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "consumption",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff7B8FA1),
                height: 0.1,
              ),
            ),
          ])),
    );
  }
}
