// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:template/data/model/response/tool_model.dart';

class ToolCollectionModel {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ToolModel>? tools;
  ToolCollectionModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.tools,
  });

  ToolCollectionModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ToolModel>? tools,
  }) {
    return ToolCollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tools: tools ?? this.tools,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'tools': tools?.map((x) => x.id.toString()).toList(),
    };
  }

  factory ToolCollectionModel.fromMap(Map<String, dynamic> map) {
    return ToolCollectionModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()).toLocal() : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt'].toString()).toLocal() : null,
      tools: map['tools'] != null
          ? (map['tools'] as List<dynamic>).map((e) {
              if (e.toString().length == 24) {
                return ToolModel(id: e.toString());
              }
              return ToolModel.fromMap(e as Map<String, dynamic>);
            }).toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToolCollectionModel.fromJson(String source) =>
      ToolCollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ToolCollectionModel(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, tools: $tools)';
  }

  @override
  bool operator ==(covariant ToolCollectionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.tools, tools);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ tools.hashCode;
  }
}
