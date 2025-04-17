import 'package:flutter/material.dart';

import '../models/monster.dart';

class MonsterMainCard extends StatelessWidget {
  final Monster monster;

  const MonsterMainCard({Key? key, required this.monster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 378,
      width: 511,
      child: const Card(
        elevation: 8,
        child: Center(
          child: (Text("Player")),
        ),
      ),
    );
  }
}
