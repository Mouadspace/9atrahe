import 'package:flutter/material.dart';

import 'widgets/background.dart';
import 'widgets/box_cercle.dart';
import 'widgets/vertical_slider.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List values1 = ["Auto", "0.33", "0.5"];
    List values2 = ["1", "2", "3"];
    List<List> listes = [values1, values2];

    return Scaffold(
      backgroundColor: const Color(0xffEEFDFE),
      body: SafeArea(
        child: Stack(children: [
          const Background(
            transaleX: -445,
            translateY: -46,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 36, top: 71),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Manage your tap\n",
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                          TextSpan(
                            text: "chose carefully",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff15233E),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliderVerticalWidget(),
                Container(
                  padding: const EdgeInsets.only(top: 29),
                  // color: Colors.lime,
                  child: Column(
                    children: [
                      ...List.generate(
                        listes.length,
                        (e) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              listes[e].length,
                              (index) => BoxCircle(
                                  value: listes[e][index], message: [e, index]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
