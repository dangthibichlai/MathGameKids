// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_bool_literals_in_conditional_expressions
import 'dart:convert';

import 'package:template/data/model/response/categories_model.dart';

class CharacterModel {
  String? id;
  List<CategoriesModel>? categoryIds;
  String? avatar;
  String? name;
  String? intro;
  int? countMessages;
  bool? isPro;
  CharacterModel({
    this.id,
    this.categoryIds,
    this.avatar,
    this.name,
    this.intro,
    this.countMessages,
    this.isPro = false,
  });

  CharacterModel copyWith({
    String? id,
    List<CategoriesModel>? categoryIds,
    String? avatar,
    String? name,
    String? intro,
    int? countMessages,
    bool? isPro,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      categoryIds: categoryIds ?? this.categoryIds,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      intro: intro ?? this.intro,
      countMessages: countMessages ?? this.countMessages,
      isPro: isPro ?? this.isPro,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryIds': categoryIds?.map((e) => e.id).toList(),
      'avatar': avatar,
      'name': name,
      'intro': intro,
      'countMessages': countMessages,
      'isPro': isPro,
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      categoryIds: map['categoryIds'] != null
          ? (map['categoryIds'] as List<dynamic>).map((e) {
              if (e.toString().length == 24) {
                return CategoriesModel(id: e.toString());
              }
              return CategoriesModel.fromMap(e as Map<String, dynamic>);
            }).toList()
          : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      intro: map['intro'] != null ? map['intro'] as String : null,
      isPro: map['isPro'] != null ? map['isPro'] as bool : false,
      countMessages: map['countMessages'] != null ? (map['countMessages'] as num).toInt() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) => CharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CharacterModel(id: $id, categoryIds: $categoryIds, avatar: $avatar, name: $name, intro: $intro, countMessages: $countMessages)';
  }

  @override
  bool operator ==(covariant CharacterModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoryIds == categoryIds &&
        other.avatar == avatar &&
        other.name == name &&
        other.intro == intro &&
        other.isPro == isPro &&
        other.countMessages == countMessages;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryIds.hashCode ^
        avatar.hashCode ^
        name.hashCode ^
        intro.hashCode ^
        isPro.hashCode ^
        countMessages.hashCode;
  }
}
