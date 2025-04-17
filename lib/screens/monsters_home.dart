import 'package:assessment_cc_flutter_sr_01/models/battle_response.dart';
import 'package:assessment_cc_flutter_sr_01/widgets/monster_list_widget.dart';
import 'package:assessment_cc_flutter_sr_01/widgets/start_battle_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/monster_service.dart';
import '../widgets/monster_battle_arena_widget.dart';

class MonsterHome extends StatelessWidget {
  const MonsterHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MonsterService monsterService =
        Provider.of<MonsterService>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                child: const Padding(
                  padding: EdgeInsets.only(top: 49, left: 22),
                  child: Text(
                    "Battle of Monsters",
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 27, left: 20),
                child: Container(
                  width: size.height,
                  child: const Text(
                    "Select your monster",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: MonsterList(),
              ),
              const SizedBox(
                height: 23,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: MonsterBattleArena(),
              ),
              const SizedBox(
                height: 21,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: StartBattleButton(),
    );
  }
}
