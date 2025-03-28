import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/features/chat_bot/models/bot_message.dart';

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

final geminiProvider = Provider<Gemini>((ref) {
  return Gemini.init(apiKey: 'AIzaSyCDvOinZEXpKnnRLbMT6O6YS-6DqAv0o64');
});

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

  Future<void> sendMessage(String text) async {
  final newMessages = [...ref.read(chatMessagesProvider)];
  newMessages.add(ChatMessage(text: text, isBot: false));
  ref.read(chatMessagesProvider.notifier).state = newMessages;
  scrollToBottom();

  final gemini = ref.read(geminiProvider);

  try {
    final response = await gemini.prompt(parts: [Part.text(text)]);

    ref.read(chatMessagesProvider.notifier).state = [
      ...ref.read(chatMessagesProvider),
      ChatMessage(
        text: response?.output ??
            'น้อง Nekky อยู่ระหว่างพัก ไม่สามารถใช้งานได้ในขณะนี้',
        isBot: true,
      ),
    ];
  } catch (e) {
    ref.read(chatMessagesProvider.notifier).state = [
      ...ref.read(chatMessagesProvider),
      ChatMessage(
        text: 'น้อง Nekky อยู่ระหว่างพัก ไม่สามารถใช้งานได้ในขณะนี้',
        isBot: true,
      ),
    ];
  }

  scrollToBottom();
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final messages = ref.watch(chatMessagesProvider);

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
            ),
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
                    style: TextStyle(fontSize: 18.0),
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
                    onChanged: (value) => ref.read(chatInputProvider.notifier).state = value,
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
                      sendMessage(text);
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
