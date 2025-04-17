import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:assessment_cc_flutter_sr_01/models/battle_response.dart';
import 'package:assessment_cc_flutter_sr_01/models/monster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MonsterService extends ChangeNotifier {
  List<Monster> _monsters = [];
  Monster? _player;
  Monster? _computer;

  BattleResponse? _battleResponse;

  UnmodifiableListView<Monster> get monsters => UnmodifiableListView(_monsters);

  Future<List<Monster>> getMonsters() async {
    final response =
        await http.get(Uri.parse('${dotenv.env["API_URL"]}/monsters'));
    if (response.statusCode == 200) {
      late Iterable it;
      if (response.body is List<dynamic>) {
        Map<String, dynamic> results = json.decode(response.body);
        it = results['monsters'] as Iterable;
      } else {
        it = jsonDecode(response.body);
      }
      _monsters =
          List<Monster>.from(it.map((monster) => Monster.fromJson(monster)));
      notifyListeners();
      return _monsters;
    } else {
      throw Exception('Failed to load monsters');
    }
  }

  Future<BattleResponse?> startBattle() async {
    if (_player == null || _computer == null) {
      throw Exception("Both player and compiter monster must be selected,");
    }
    final url = Uri.parse('${dotenv.env["API_URL"]}/battle');
    final body = {'monster1Id': _player!.id, 'monster2Id': _computer!.id};

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BattleResponse.fromJson(data);
      } else {
        throw Exception('Failed to start battle ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error starting battle: $e');
    }
  }

  void selectMonster(Monster monster) {
    if (_player != null && _player?.id == monster.id) {
      //If the same monster is selected so
      //the monster is deselected
      _player = null;
      _computer = null;
    } else {
      _player = monster;
      generateCPUMonster();
    }
    notifyListeners();
  }

  set player(Monster? currentPlayer) {
    _player = currentPlayer;
    notifyListeners();
  }

  Monster? get player => _player;

  BattleResponse? get battleResponse => _battleResponse;

  Monster? get computer => _computer;

  void generateCPUMonster() {
    if (_player == null) return;

    final availableMoster =
        _monsters.where((monster) => monster.id != _player?.id).toList();

    if (availableMoster.isNotEmpty) {
      final randomIdex = Random().nextInt(availableMoster.length);
      _computer = availableMoster[randomIdex];
    } else {
      _computer = null;
    }
  }
}
