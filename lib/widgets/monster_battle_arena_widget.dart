import 'package:assessment_cc_flutter_sr_01/utils/player_type_enum.dart';
import 'package:flutter/material.dart';

import 'monster_battle_item_widget.dart';

class MonsterBattleArena extends StatelessWidget {
  final List<MonsterItem> monsters = const [
    MonsterItem(type: PlayerType.player),
    MonsterItem(type: PlayerType.computer)
  ];

  const MonsterBattleArena({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.55,
      width: 373,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: monsters.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 28),
                child: monsters[index],
              )),
    );
  }
}
