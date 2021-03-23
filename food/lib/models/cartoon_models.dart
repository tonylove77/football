import 'dart:convert';

class CartoonModel {

   final String name;
   final String cover;
  CartoonModel({
    this.name,
    this.cover,
  });

  

  CartoonModel copyWith({
    String name,
    String cover,
  }) {
    return CartoonModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cover': cover,
    };
  }

  factory CartoonModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CartoonModel(
      name: map['name'],
      cover: map['cover'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartoonModel.fromJson(String source) => CartoonModel.fromMap(json.decode(source));

  @override
  String toString() => 'CartoonModel(name: $name, cover: $cover)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CartoonModel &&
      o.name == name &&
      o.cover == cover;
  }

  @override
  int get hashCode => name.hashCode ^ cover.hashCode;
}
