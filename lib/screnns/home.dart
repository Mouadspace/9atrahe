import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import '../models/home_modeles.dart';
import 'widgets/background.dart';
import 'widgets/consumption.dart';
import 'widgets/profile_picture.dart';
import 'widgets/toogle_container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffEEFDFE),
      body: SafeArea(
        child: Stack(children: [
          const Background(
            transaleX: 103,
            translateY: -57,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfilePicture(),
                const Consumption(), // stream builder
                SizedBox(
                  height: 240,
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: homeList.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ToggleContainer(
                        homeModel: homeList[index],
                      );
                    },
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
