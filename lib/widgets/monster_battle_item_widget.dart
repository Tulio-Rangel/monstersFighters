import 'package:assessment_cc_flutter_sr_01/services/monster_service.dart';
import 'package:assessment_cc_flutter_sr_01/utils/player_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/monster.dart';

class MonsterItem extends StatefulWidget {
  final PlayerType type;

  const MonsterItem({Key? key, required this.type}) : super(key: key);

  @override
  State<MonsterItem> createState() => _MonsterItemState();
}

class _MonsterItemState extends State<MonsterItem> {
  Widget _defaultContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Text(
        widget.type.playerName,
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }

  Widget _currentMonsterWidget(Monster? monster) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Image.network(
              monster!.imageUrl,
              height: 148,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          monster.name,
          style: const TextStyle(fontSize: 22),
        ),
        Divider(
          color: Colors.grey[300],
        ),
        //const SizedBox(height: 8),
        // Barra de progreso para HP
        _attributeBar("HP", monster.hp),
        // Barra de progreso para Ataque
        _attributeBar("Attack", monster.attack),
        // Barra de progreso para Defensa
        _attributeBar("Defense", monster.defense),
        // Barra de progreso para Velocidad
        _attributeBar("Speed", monster.speed),
      ],
    );
  }

  Widget _buildCurrentWidget(MonsterService monsterService) {
    Size size = MediaQuery.of(context).size;
    late Widget currentWidget;
    switch (widget.type) {
      case PlayerType.player:
        currentWidget = monsterService.player != null
            ? _currentMonsterWidget(monsterService.player)
            : _defaultContent(context);
        break;
      case PlayerType.computer:
        currentWidget = monsterService.computer != null
            ? _currentMonsterWidget(monsterService.computer)
            : _defaultContent(context);
        break;
      default:
        currentWidget = _defaultContent(context);
    }

    return Container(
      width: size.width,
      height: size.height,
      child: Card(
        elevation: 8,
        child: Padding(padding: const EdgeInsets.all(8), child: currentWidget),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MonsterService monsterService =
        Provider.of<MonsterService>(context, listen: true);

    return Container(
      width: size.width * 0.70,
      child: _buildCurrentWidget(monsterService),
    );
  }
}

Widget _attributeBar(String label, int value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 4),
      LinearProgressIndicator(
        value: value / 100, // Asume que el valor máximo es 100
        backgroundColor: Colors.grey[350],
        color: const Color(0xFF00FF00),
        minHeight: 8,
        borderRadius: BorderRadius.circular(4),
      ),
      const SizedBox(height: 8),
    ],
  );
}
