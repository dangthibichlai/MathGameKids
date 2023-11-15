// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';

class CategoriesModel {
  String? id;
  String? title;
  int? position;
  String? description;
  String? image;
  CategoriesModel({
    this.id,
    this.title,
    this.position,
    this.description,
    this.image,
  });

  CategoriesModel copyWith({
    String? id,
    String? title,
    int? position,
    String? description,
    String? image,
  }) {
    return CategoriesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      position: position ?? this.position,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'position': position,
      'description': description,
      'image': image,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      title: map['title'] != null
          ? !IZIValidate.nullOrEmpty((map['title'] as Map<String, dynamic>)[sl<SharedPreferenceHelper>().getLocale])
              ? (map['title'] as Map<String, dynamic>)[sl<SharedPreferenceHelper>().getLocale]
              : (map['title'] as Map<String, dynamic>)['en']
          : null,
      position: map['position'] != null ? (map['position'] as num).toInt() : null,
      description: map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoriesModel(id: $id, title: $title, position: $position, description: $description, image: $image)';
  }

  @override
  bool operator ==(covariant CategoriesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.position == position &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ position.hashCode ^ description.hashCode ^ image.hashCode;
  }
}
