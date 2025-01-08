// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/chats_controller.dart';
import 'package:promotion_dashboard/view/widgets/messages/show_chat.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatsControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Chats',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {}),
            PopupMenuButton<String>(
              onSelected: (value) {},
              icon: Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (context) {
                return ['Settings', 'Log Out']
                    .map((e) => PopupMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList();
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: controller.getChatList().length,
          itemBuilder: (context, index) {
            final chat = controller.getChatList()[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[300],
                child: Text(
                  chat['name']![0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(chat['name']!),
              subtitle: Text(chat['lastMessage']!),
              onTap: () {
                controller.openChat(index);
                if (MediaQuery.of(context).size.width <= 600) {
                  Get.to(() => ShowChat());
                }
              },
            );
          },
        ),
      );
    });
  }
}
