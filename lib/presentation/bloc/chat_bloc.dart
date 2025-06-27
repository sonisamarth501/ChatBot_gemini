import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bot/domain/entities/chat.dart';
import 'package:flutter_bot/domain/entities/chat_part.dart';
import 'package:flutter_bot/domain/usecases/generate_chat_usecase.dart';
import 'package:flutter_bot/presentation/bloc/chat_events.dart';
import 'package:flutter_bot/presentation/bloc/chat_states.dart';

class ChatBloc extends Bloc<ChatEvents, ChatStates> {
  final GenerateChatUsecase generateChatUsecase;

  ChatBloc(this.generateChatUsecase) : super(ChatInitialState()) {
    on<GenerateChatEvent>(generateChat);
  }

  List<ChatModel> messages = [];

  FutureOr<void> generateChat(
    GenerateChatEvent event,
    Emitter<ChatStates> emit,
  ) async {
    messages.add(
      ChatModel(
        role: 'user',
        parts: [ChatParts(text: event.userMesg)],
      ),
    );
    emit(GenerateChatSuccessState(chats: messages));
    String answer = await generateChatUsecase.execute(messages);

    messages.add(
      ChatModel(
        role: 'model',
        parts: [ChatParts(text: answer)],
      ),
    );
    emit(GenerateChatSuccessState(chats: messages));

    //TODO:Handle the error state...--> HM
  }
}
