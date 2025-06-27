import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bot/domain/entities/chat.dart';
import 'package:flutter_bot/presentation/bloc/chat_bloc.dart';
import 'package:flutter_bot/presentation/bloc/chat_events.dart';
import 'package:flutter_bot/presentation/bloc/chat_states.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController promptController = TextEditingController();

  final ChatBloc chatBloc = GetIt.I<ChatBloc>();
  // DI
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => chatBloc,
      child: BlocBuilder<ChatBloc, ChatStates>(
        builder: (context, state) {
          List<ChatModel> messaages = [];

          if (state is GenerateChatSuccessState) {
            messaages = state.chats;
          }
          return Scaffold(
            appBar: AppBar(title: const Text("Flutter Bot")),
            body: Column(
              children: [
                Expanded(
                  child: messaages.isEmpty
                      ? SizedBox() //TODO: Display a message to user
                      : ListView.builder(
                          itemCount: messaages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    messaages[index].role == 'user'
                                        ? "User"
                                        : "Model",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 12,
                                      left: 10,
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: messaages[index]
                                                .parts
                                                .first
                                                .text,
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: promptController,
                          decoration: InputDecoration(
                            hintText: "Enter a prompt here...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey,
                          ),
                        ),
                      ),
                      IconButton.filled(
                        onPressed: () {
                          chatBloc.add(
                            GenerateChatEvent(userMesg: promptController.text),
                          );
                          promptController.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
