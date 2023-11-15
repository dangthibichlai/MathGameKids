// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ToolModel {
  String? id;
  String? name;
  String? description;
  String? thumbnail;
  String? key;
  ToolModel({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.key,
  });

  ToolModel copyWith({
    String? id,
    String? name,
    String? description,
    String? thumbnail,
    String? key,
  }) {
    return ToolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'key': key,
    };
  }

  factory ToolModel.fromMap(Map<String, dynamic> map) {
    return ToolModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
      key: map['key'] != null ? map['key'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToolModel.fromJson(String source) => ToolModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ToolModel(id: $id, name: $name, description: $description, thumbnail: $thumbnail, key: $key)';
  }

  @override
  bool operator ==(covariant ToolModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.thumbnail == thumbnail &&
        other.key == key;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ thumbnail.hashCode ^ key.hashCode;
  }
}
