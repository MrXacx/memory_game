import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameCard extends StatelessWidget {
  late IconData icon, _storedIcon;

  GameCard({super.key, required IconData icon}) {
    _storedIcon = icon;
  }

  IconData get storedIcon => _storedIcon;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {},
        icon: Icon(icon),
      );
}
