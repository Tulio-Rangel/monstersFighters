class Monster {
  final String _name;
  final String _imageUrl;
  final int _attack;
  final int _defense;
  final int _hp;
  final int _speed;
  final String _id;

  String get name => _name;
  String get imageUrl => _imageUrl;
  String get id => _id;
  int get attack => _attack;
  int get defense => _defense;
  int get hp => _hp;
  int get speed => _speed;

  Monster.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _imageUrl = json['imageUrl'],
        _attack = json["attack"],
        _defense = json["defense"],
        _hp = json["hp"],
        _speed = json["speed"];
}
