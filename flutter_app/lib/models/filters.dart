class Modelo{
  final int id;
  final String name;
  Modelo({required this.id, required this.name});

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
        id: json['id'], name: json['name']
    );
  }
}


class Marca{
  final int id;
  final String name;
  Marca({required this.id, required this.name});

  factory Marca.fromJson(Map<String, dynamic> json) {
    return Marca(
        id: json['id'], name: json['name']
    );
  }
}

class Color{
  final int id;
  final String name;
  Color({required this.id, required this.name});

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
        id: json['id'], name: json['name']
    );
  }
}

class Talla{
  final int id;
  final String name;
  Talla({required this.id, required this.name});

  factory Talla.fromJson(Map<String, dynamic> json) {
    return Talla(
        id: json['id'], name: json['name']
    );
  }
}