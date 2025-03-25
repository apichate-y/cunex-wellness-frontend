import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/core/services/chatbot_service.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/features/chat_bot/models/bot_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessagesProvider = StateProvider<List<ChatMessage>>(
  (ref) => [
    ChatMessage(
      text:
          'เฮลโหล~ น้อง Nexky มาแล้ว! พร้อมเป็นเพื่อนคุยคลายเหงา และเติมพลังใจให้เธอนะ!',
      isBot: true,
    ),
  ],
);

final chatInputProvider = StateProvider<String>((ref) => '');

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

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
    final messages = ref.watch(chatMessagesProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   backgroundColor: AppTheme.rosePink,
      //   elevation: 0,
      //   title: const Text(
      //     'NEKKY CHATBOT',
      //     style: TextStyle(color: AppTheme.black, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          const CustomAppbar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: AppTheme.greyUltraLight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: Colors.black, // หรือใช้ AppTheme.black ถ้ามี
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text(
                      'NEKKY CHATBOT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // หรือ AppTheme.black
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
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
                            backgroundColor: AppTheme.white,
                            backgroundImage: AssetImage(
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
                              color: isBot ? AppTheme.black : AppTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
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
                    onChanged:
                        (value) =>
                            ref.read(chatInputProvider.notifier).state = value,
                    onTap: scrollToBottom,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFFD16A86),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      final text = inputController.text.trim();
                      if (text.isEmpty) return;

                      final newMessages = [...ref.read(chatMessagesProvider)];
                      newMessages.add(ChatMessage(text: text, isBot: false));
                      newMessages.add(
                        ChatMessage(
                          text: ChatBotService.getMessageByKeyword(text),
                          isBot: true,
                        ),
                      );

                      ref.read(chatMessagesProvider.notifier).state =
                          newMessages;
                      inputController.clear();
                      scrollToBottom();
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
