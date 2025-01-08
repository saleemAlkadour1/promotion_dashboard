// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/chats_controller.dart';
import 'package:promotion_dashboard/view/widgets/messages/chat_list.dart';
import 'package:promotion_dashboard/view/widgets/messages/show_chat.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ChatsControllerImp());
    return LayoutBuilder(
      builder: (context, constraints) {
        // الشاشات الكبيرة
        if (constraints.maxWidth > 600) {
          return Scaffold(
            backgroundColor: Colors.blue[50],
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ChatList(),
                ),
                VerticalDivider(
                  color: Colors.blue[200],
                  width: 1,
                ),
                Expanded(
                  flex: 3,
                  child: ShowChat(),
                ),
              ],
            ),
          );
        }
        // شاشات الموبايل والتابلت
        return ChatList();
      },
    );
  }
}
