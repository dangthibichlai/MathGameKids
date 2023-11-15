// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:template/data/model/response/conversation_model.dart';
import 'package:template/data/model/response/tool_model.dart';
import 'package:template/data/model/response/user_model.dart';
import 'package:template/core/helper/izi_validate.dart';

class MessageModel {
  String? id;
  ConversationModel? conversationId;
  UserModel? userId;
  String? text;
  String? images;
  String? document;
  String? replyFromBot;
  DateTime? createdAt;
  bool? isRenderingReply;
  File? imageFile;
  ToolModel? diyId;
  MessageModel({
    this.id,
    this.conversationId,
    this.userId,
    this.text,
    this.images,
    this.document,
    this.replyFromBot,
    this.createdAt,
    this.isRenderingReply = false,
    this.imageFile,
    this.diyId,
  });

  MessageModel copyWith({
    String? id,
    ConversationModel? conversationId,
    UserModel? userId,
    String? text,
    String? images,
    String? document,
    String? replyFromBot,
    DateTime? createdAt,
    bool? isRenderingReply,
    File? imageFile,
    ToolModel? diyId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      images: images ?? this.images,
      document: document ?? this.document,
      replyFromBot: replyFromBot ?? this.replyFromBot,
      isRenderingReply: isRenderingReply ?? this.isRenderingReply,
      createdAt: createdAt ?? this.createdAt,
      imageFile: imageFile ?? this.imageFile,
      diyId: diyId ?? this.diyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(conversationId)) 'characterId': conversationId?.characterId!.id,
      if (!IZIValidate.nullOrEmpty(userId)) 'userId': userId?.id,
      if (!IZIValidate.nullOrEmpty(text)) 'text': text,
      if (!IZIValidate.nullOrEmpty(images)) 'images': images,
      if (!IZIValidate.nullOrEmpty(document)) 'document': document,
      if (!IZIValidate.nullOrEmpty(replyFromBot)) 'replyFromBot': replyFromBot,
      if (!IZIValidate.nullOrEmpty(diyId)) 'diyId': diyId?.id.toString(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      conversationId: map['conversationId'] != null
          ? map['conversationId'].toString().length == 24
              ? ConversationModel(id: map['conversationId'].toString())
              : ConversationModel.fromMap(map['conversationId'] as Map<String, dynamic>)
          : null,
      userId: map['userId'] != null
          ? map['userId'].toString().length == 24
              ? UserModel(id: map['userId'].toString())
              : UserModel.fromMap(map['userId'] as Map<String, dynamic>)
          : null,
      diyId: map['diyId'] != null
          ? map['diyId'].toString().length == 24
              ? ToolModel(id: map['diyId'].toString())
              : ToolModel.fromMap(map['diyId'] as Map<String, dynamic>)
          : null,
      text: map['text'] != null ? map['text'] as String : null,
      images: map['images'] != null ? map['images'] as String : null,
      document: map['document'] != null ? map['document'] as String : null,
      replyFromBot: map['replyFromBot'] != null ? map['replyFromBot'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()).toLocal() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, conversationId: $conversationId, userId: $userId, text: $text, images: $images, document: $document, replyFromBot: $replyFromBot, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.conversationId == conversationId &&
        other.userId == userId &&
        other.text == text &&
        other.images == images &&
        other.document == document &&
        other.replyFromBot == replyFromBot &&
        other.isRenderingReply == isRenderingReply &&
        other.imageFile == imageFile &&
        other.diyId == diyId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conversationId.hashCode ^
        userId.hashCode ^
        text.hashCode ^
        images.hashCode ^
        document.hashCode ^
        replyFromBot.hashCode ^
        isRenderingReply.hashCode ^
        imageFile.hashCode ^
        diyId.hashCode ^
        createdAt.hashCode;
  }
}
