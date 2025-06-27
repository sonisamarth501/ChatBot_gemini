import 'package:flutter_bot/domain/entities/chat.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class GenerateChatSuccessState extends ChatStates {
  final List<ChatModel> chats;

  GenerateChatSuccessState({required this.chats});
}

class GenerateChatFailureState extends ChatStates {
  final String eMessage;

  GenerateChatFailureState({required this.eMessage});
}
