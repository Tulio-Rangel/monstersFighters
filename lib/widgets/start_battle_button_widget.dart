import 'package:assessment_cc_flutter_sr_01/services/monster_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class StartBattleButton extends StatefulWidget {
  const StartBattleButton({Key? key}) : super(key: key);

  @override
  State<StartBattleButton> createState() => _StartBattleButtonState();
}

class _StartBattleButtonState extends State<StartBattleButton> {
  String buttonText = "Start Battle";
  bool battleFinished = false;

  final ButtonStyle _enableButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(
      const Color(0xFF10782E),
    ),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );
  final ButtonStyle _disabledButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(
      const Color(0xFF799A82),
    ),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );
  final ButtonStyle _finishedButtonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFE1F8FF)),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: Colors.black, width: 1)));

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en MonsterService
    final monsterService = Provider.of<MonsterService>(context, listen: false);
    monsterService.addListener(_onMonsterServiceChange);
  }

  @override
  void dispose() {
    // Limpiar el listener al destruir el widget
    final monsterService = Provider.of<MonsterService>(context, listen: false);
    monsterService.removeListener(_onMonsterServiceChange);
    super.dispose();
  }

  void _onMonsterServiceChange() {
    final monsterService = Provider.of<MonsterService>(context, listen: false);
    // Reiniciar el estado si los monstruos cambian
    if (battleFinished &&
        (monsterService.player != null || monsterService.computer != null)) {
      setState(() {
        buttonText = "Start Battle";
        battleFinished = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MonsterService monsterService =
        Provider.of<MonsterService>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
        width: size.width * 0.85,
        height: 56,
        child: ElevatedButton(
          style: battleFinished
              ? _finishedButtonStyle
              : (monsterService.player != null &&
                      monsterService.computer != null
                  ? _enableButtonStyle
                  : _disabledButtonStyle),
          onPressed: !battleFinished
              ? () async {
                  final battleResponse = await monsterService.startBattle();
                  if (battleResponse != null) {
                    setState(() {
                      buttonText = "${battleResponse.winner?.name} wins!";
                      battleFinished = true;
                    });
                  }
                }
              : null,
          child: Text(buttonText),
        ),
      ),
    );
  }
}
