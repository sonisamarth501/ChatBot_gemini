import 'package:flutter_bot/domain/entities/chat.dart';

abstract class ChatRepository {
  Future<String> generateChat(List<ChatModel> preChat);
}
