// lib/screens/chat_screen.dart
import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/features/chat_bot/providers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late ChatController controller;
  
  @override
  void initState() {
    super.initState();
    controller = Get.find<ChatController>();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          Container(
            height: 90,
            color: AppTheme.greyUltraLight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'CHAT WITH NEKKY',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              scrollToBottom();
              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  final message = controller.chatMessages[index];
                  final isBot = message.isBot;

                  return Align(
                    alignment:
                        isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isBot) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: const AssetImage(
                                'lib/assets/images/element/j.png',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  isBot
                                      ? AppTheme.greyUltraLight
                                      : AppTheme.rosePink,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              message.text,
                              style: TextStyle(
                                fontSize: 18,
                                color: isBot ? AppTheme.black : AppTheme.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.fromLTRB(
              screenHeight * 0.02,
              8,
              screenHeight * 0.02,
              screenHeight * 0.09,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      hintText: 'พิมพ์ข้อความ...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) => controller.chatInput.value = value,
                    onTap: scrollToBottom,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppTheme.rosePink,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      final text = inputController.text.trim();
                      if (text.isEmpty) return;
                      inputController.clear();
                      controller.sendMessage(text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}