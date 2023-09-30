import 'package:flutter/material.dart';

class RattingItem extends StatelessWidget {
  final int index;
  final int ratting;

  const RattingItem({super.key, required this.index, required this.ratting});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      index <= ratting ? 'assets/iconStar.png' : 'assets/Icon_star_solid.png',
      width: 20,
    );
  }
}
