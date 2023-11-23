import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameCard extends StatelessWidget {
  late Image icon, _storedIcon;

  GameCard({super.key, required this.icon}) {
    _storedIcon = icon;
  }

  Image get storedIcon => _storedIcon;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        child: icon,
      );
}
