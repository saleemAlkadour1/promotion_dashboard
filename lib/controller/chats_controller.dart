import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ChatsController extends GetxController {
  List<Map<String, String>> getChatList();
  void openChat(int index);
  void sendMessage(String message);
  late TextEditingController messageController;
}

class ChatsControllerImp extends ChatsController {
  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
  }

  List<Map<String, String>> chats = [
    {"name": "John Doe", "lastMessage": "Hello! How are you?"},
    {"name": "Jane Smith", "lastMessage": "Are we still on for today?"},
    {"name": "Michael Brown", "lastMessage": "Sure, I’ll call you later."},
    {"name": "Alice Green", "lastMessage": "Thanks for the update."},
    {"name": "John Doe", "lastMessage": "Hello! How are you?"},
    {"name": "Jane Smith", "lastMessage": "Are we still on for today?"},
    {"name": "Michael Brown", "lastMessage": "Sure, I’ll call you later."},
    {"name": "Alice Green", "lastMessage": "Thanks for the update."},
    {"name": "John Doe", "lastMessage": "Hello! How are you?"},
    {"name": "Jane Smith", "lastMessage": "Are we still on for today?"},
    {"name": "Michael Brown", "lastMessage": "Sure, I’ll call you later."},
    {"name": "Alice Green", "lastMessage": "Thanks for the update."},
  ];

  String? activeChatName;
  List<String> messages = [];

  @override
  List<Map<String, String>> getChatList() {
    return chats;
  }

  @override
  void openChat(int index) {
    activeChatName = chats[index]["name"];
    messages = []; // تفريغ الرسائل لبدء محادثة جديدة
    update();
  }

  @override
  void sendMessage(String message) {
    if (message.trim().isNotEmpty) {
      messages.add(message);
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
}
