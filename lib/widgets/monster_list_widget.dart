import 'package:assessment_cc_flutter_sr_01/services/monster_service.dart';
import 'package:assessment_cc_flutter_sr_01/widgets/monster_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/monster.dart';

class MonsterList extends StatefulWidget {
  const MonsterList({Key? key}) : super(key: key);

  @override
  State<MonsterList> createState() => _MonsterListState();
}

class _MonsterListState extends State<MonsterList> {
  List<Monster>? _monsters;

  Future<List<Monster>> _getMonsterList(BuildContext context) async {
    return await Provider.of<MonsterService>(
      context,
      listen: false,
    ).getMonsters();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_monsters == null) {
      List<Monster> tmpMonster = await _getMonsterList(context);
      setState(() {
        _monsters = tmpMonster;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 139,
      child: _monsters != null
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _monsters?.length,
              itemBuilder: (context, index) =>
                  MonsterHeaderCard(monster: _monsters![index]),
            )
          : const Center(
              child: Text("No Monsters"),
            ),
    );
  }
}
