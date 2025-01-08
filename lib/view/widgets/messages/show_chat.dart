// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/chats_controller.dart';

class ShowChat extends StatelessWidget {
  const ShowChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatsControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              controller.activeChatName ?? 'No Chat Selected',
              style: TextStyle(color: Colors.white),
            )),
        body: controller.activeChatName == null
            ? Center(
                child: Text(
                  'No Chat Selected',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              controller.messages[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.blue),
                          onPressed: () {
                            controller
                                .sendMessage(controller.messageController.text);
                            controller.messageController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
