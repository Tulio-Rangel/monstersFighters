import 'package:flutter/foundation.dart' show describeEnum;

enum PlayerType { player, computer }

extension PlayerTypeExtension on PlayerType {
  String get name => describeEnum(this);

  String get playerName {
    switch (this) {
      case PlayerType.player:
        return "Player";
      case PlayerType.computer:
        return "Computer";
      default:
        return "Select a player";
    }
  }
}
