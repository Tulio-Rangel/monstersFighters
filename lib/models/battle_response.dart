import 'monster.dart';

class BattleResponse {
  Monster? _winner;
  bool? _tie;
  String? _message;

  Monster? get winner => _winner;
  bool? get tie => _tie;
  String? get message => _message;

  BattleResponse.fromJson(Map<String, dynamic> json) {
    if (json['winner'] != null) {
      _winner = Monster.fromJson(json['winner']);
    }
    _tie = json['tie'] ?? false;
    _message = json['message'] ?? '';
  }
}
