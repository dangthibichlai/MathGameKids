// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_bool_literals_in_conditional_expressions
import 'dart:convert';

import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';

class DIYModel {
  String? id;
  String? firstMessage;
  String? name;
  String? description;
  String? avatar;
  bool? isAppDiy;
  UserModel? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DIYModel({
    this.id,
    this.firstMessage,
    this.name,
    this.description,
    this.avatar,
    this.isAppDiy,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  DIYModel copyWith({
    String? id,
    String? firstMessage,
    String? name,
    String? description,
    String? avatar,
    bool? isAppDiy,
    UserModel? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DIYModel(
      id: id ?? this.id,
      firstMessage: firstMessage ?? this.firstMessage,
      name: name ?? this.name,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
      isAppDiy: isAppDiy ?? this.isAppDiy,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) '_id': id,
      if (!IZIValidate.nullOrEmpty(firstMessage)) 'firstMessage': firstMessage,
      if (!IZIValidate.nullOrEmpty(name)) 'name': name,
      if (!IZIValidate.nullOrEmpty(description)) 'description': description,
      if (!IZIValidate.nullOrEmpty(avatar)) 'avatar': avatar,
      if (!IZIValidate.nullOrEmpty(isAppDiy)) 'isAppDiy': isAppDiy,
      if (!IZIValidate.nullOrEmpty(userId)) 'userId': userId?.id,
      if (!IZIValidate.nullOrEmpty(createdAt)) 'createdAt': createdAt?.millisecondsSinceEpoch,
      if (!IZIValidate.nullOrEmpty(updatedAt)) 'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory DIYModel.fromMap(Map<String, dynamic> map) {
    return DIYModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      firstMessage: map['firstMessage'] != null ? map['firstMessage'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      isAppDiy: map['isAppDiy'] != null ? map['isAppDiy'] as bool : false,
      userId: map['userId'] != null
          ? map['userId'].toString().length == 24
              ? UserModel(id: map['userId'].toString())
              : UserModel.fromMap(map['userId'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()).toLocal() : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt'].toString()).toLocal() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DIYModel.fromJson(String source) => DIYModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DIYModel(id: $id, firstMessage: $firstMessage, name: $name, description: $description, avatar: $avatar, isAppDiy: $isAppDiy, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant DIYModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstMessage == firstMessage &&
        other.name == name &&
        other.description == description &&
        other.avatar == avatar &&
        other.isAppDiy == isAppDiy &&
        other.userId == userId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstMessage.hashCode ^
        name.hashCode ^
        description.hashCode ^
        avatar.hashCode ^
        isAppDiy.hashCode ^
        userId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
