import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 77),
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(21),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Image.asset(
            "assets/images/profile.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
