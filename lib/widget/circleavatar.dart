import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({
    super.key,
    required this.inital,
  });

  final String? inital;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor:
          Colors.primaries[Random().nextInt(Colors.primaries.length)],
      radius: 30,
      child: Text(
        inital!.toUpperCase(),
        style: const TextStyle(
            fontSize: 26, fontWeight: FontWeight.w600, color: kwhitecolor),
      ),
    );
  }
}
