class HomeModel {
  final String text, subText;
  final String iconPath;

  HomeModel({
    required this.text,
    required this.subText,
    required this.iconPath,
  });
}

List<HomeModel> homeList = [
  HomeModel(
    text: "turn off",
    subText: "Water",
    iconPath: "assets/svgs/drop.svg",
  ),
  HomeModel(
    text: "turn on",
    subText: "light",
    iconPath: "assets/svgs/bulb.svg",
  ),
];
