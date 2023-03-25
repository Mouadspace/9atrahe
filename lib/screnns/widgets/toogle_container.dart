import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/home_modeles.dart';
import './custom_toggle.dart';

class ToggleContainer extends StatelessWidget {
  final HomeModel homeModel;
  const ToggleContainer({super.key, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 34, top: 69),
          padding: const EdgeInsets.only(left: 18, bottom: 25),
          width: 149,
          height: 168,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CustomToggle(
                  onToggled: (isToggled) {
                    print(isToggled);
                  },
                ),
              ),
              Text(
                homeModel.text,
                style: const TextStyle(
                  color: Color(0xff15233e),
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                homeModel.subText,
                style: const TextStyle(
                  color: Color(0xff7B8FA1),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -18,
          right: -18,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xff15233e),
              borderRadius: BorderRadius.circular(24),
            ),
            child: SvgPicture.asset(
              homeModel.iconPath,
            ),
          ),
        ),
      ],
    );
  }
}
