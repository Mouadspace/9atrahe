import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample_bluetooth_serial/screnns/control_screen.dart';

class SliderVerticalWidget extends StatefulWidget {
  @override
  _SliderVerticalWidgetState createState() => _SliderVerticalWidgetState();
}

class _SliderVerticalWidgetState extends State<SliderVerticalWidget> {
  double value = 4;

  @override
  Widget build(BuildContext context) {
    const double min = 0;
    const double max = 10;

    return Padding(
      padding: const EdgeInsets.only(top: 51),
      child: SliderTheme(
        data: SliderThemeData(
          activeTrackColor: const Color(0xff3AB2FF),
          inactiveTrackColor: const Color(0xffD4F4FE),
          trackHeight: 157,
          thumbShape: SliderComponentShape.noOverlay,
          overlayShape: SliderComponentShape.noOverlay,
          valueIndicatorShape: SliderComponentShape.noOverlay,

          trackShape: const RectangularSliderTrackShape(),

          /// ticks in between
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
        ),
        child: ClipRRect(
          // add it
          borderRadius: BorderRadius.circular(28),
          child: SizedBox(
            height: 332,
            width: 157, // add it
            child: Stack(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: ClipRRect(
                    child: Slider(
                      value: value,
                      min: min,
                      max: max,
                      divisions: 10,
                      label: value.round().toString(), // nothing
                      onChanged: (value) => setState(() {
                        this.value = value;
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${value.round()}',
                                style: const TextStyle(
                                  color: Color(0xff15233E),
                                  fontSize: 28,
                                ),
                              ),
                              const TextSpan(
                                text: "litres",
                                style: TextStyle(
                                  color: Color.fromARGB(127, 21, 35, 62),
                                  fontSize: 22,
                                ),
                              )
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/svgs/drop_outline.svg",
                          width: 35,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
