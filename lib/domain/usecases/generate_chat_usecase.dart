import 'package:flutter_bot/domain/entities/chat.dart';
import 'package:flutter_bot/domain/repository/chat_repository.dart';

class GenerateChatUsecase {
  final ChatRepository repository;

  GenerateChatUsecase(this.repository);

  Future<String> execute(List<ChatModel> preChat) async {
    return await repository.generateChat(preChat);
  }
}
