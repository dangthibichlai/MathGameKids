// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/data/model/response/character_model.dart';
import 'package:template/data/model/response/user_model.dart';
import 'package:template/core/helper/izi_validate.dart';

class ConversationModel {
  String? id;
  CharacterModel? characterId;
  UserModel? userId;
  String? chatName;
  String? latestMessage;
  String? latestReplyMessage;
  DateTime? createdAt;
  ConversationModel({
    this.id,
    this.characterId,
    this.userId,
    this.chatName,
    this.latestMessage,
    this.latestReplyMessage,
    this.createdAt,
  });

  ConversationModel copyWith({
    String? id,
    CharacterModel? characterId,
    UserModel? userId,
    String? chatName,
    String? latestMessage,
    String? latestReplyMessage,
    DateTime? createdAt,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      userId: userId ?? this.userId,
      chatName: chatName ?? this.chatName,
      latestMessage: latestMessage ?? this.latestMessage,
      latestReplyMessage: latestReplyMessage ?? this.latestReplyMessage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) '_id': id,
      if (!IZIValidate.nullOrEmpty(characterId)) 'characterId': characterId?.id,
      if (!IZIValidate.nullOrEmpty(userId)) 'userId': userId?.id,
      if (!IZIValidate.nullOrEmpty(chatName)) 'chatName': chatName,
      if (!IZIValidate.nullOrEmpty(latestMessage)) 'latestMessage': latestMessage,
      if (!IZIValidate.nullOrEmpty(latestReplyMessage)) 'latestReplyMessage': latestReplyMessage,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      characterId: map['characterId'] != null
          ? map['characterId'].toString().length == 24
              ? CharacterModel(id: map['characterId'].toString())
              : CharacterModel.fromMap(map['characterId'] as Map<String, dynamic>)
          : null,
      userId: map['userId'] != null
          ? map['userId'].toString().length == 24
              ? UserModel(id: map['userId'].toString())
              : UserModel.fromMap(map['userId'] as Map<String, dynamic>)
          : null,
      chatName: map['chatName'] != null ? map['chatName'] as String : null,
      latestMessage: map['latestMessage'] != null ? map['latestMessage'] as String : null,
      latestReplyMessage: map['latestReplyMessage'] != null ? map['latestReplyMessage'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()).toLocal() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConversationModel(id: $id, characterId: $characterId, userId: $userId, chatName: $chatName, latestMessage: $latestMessage, latestReplyMessage: $latestReplyMessage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ConversationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.characterId == characterId &&
        other.userId == userId &&
        other.chatName == chatName &&
        other.latestMessage == latestMessage &&
        other.latestReplyMessage == latestReplyMessage &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        characterId.hashCode ^
        userId.hashCode ^
        chatName.hashCode ^
        latestMessage.hashCode ^
        latestReplyMessage.hashCode ^
        createdAt.hashCode;
  }
}
