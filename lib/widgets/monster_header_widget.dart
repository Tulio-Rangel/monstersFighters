import 'package:assessment_cc_flutter_sr_01/services/monster_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/monster.dart';

class MonsterHeaderCard extends StatelessWidget {
  final Monster monster;

  const MonsterHeaderCard({Key? key, required this.monster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MonsterService monsterService = Provider.of<MonsterService>(context);
    return Container(
      width: 150,
      height: size.height,
      child: GestureDetector(
        onTap: () {
          monsterService.selectMonster(monster);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 7, top: 6, right: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 136,
                    height: 99,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(monster.imageUrl),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Container(
                      width: size.width,
                      child: Text(monster.name),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
