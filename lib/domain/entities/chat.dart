import 'dart:convert';

import 'package:flutter_bot/domain/entities/chat_part.dart';

class ChatModel {
  final String role;
  final List<ChatParts> parts;

  ChatModel({required this.role, required this.parts});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'role': role});
    result.addAll({'parts': parts.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      role: map['role'] ?? '',
      parts: List<ChatParts>.from(
        map['parts']?.map((x) => ChatParts.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}
