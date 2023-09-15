import 'package:chatapp/app/services/chatservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chatting_page_controller.dart';

class ChattingPageView extends GetView<ChattingPageController> {
  final String receiverUserEmail;
  final String receiverUserId;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ChattingPageView(this.receiverUserEmail, this.receiverUserId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController message = TextEditingController();
    final ChatService _chatservice = ChatService();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    final Map<String, dynamic> arguments = Get.arguments;
    final String pass = arguments['receiverid'];
    final String useremail = arguments['useremail'];

    void sendMessage() async {
      if (message.text.isNotEmpty) {
        await _chatservice.sendMessage(receiverUserId, message.text);
        //message.clear();
      }
    }

    void getMessage() async {}

    return Scaffold(
      appBar: AppBar(
        title: Text('ChatPage'), // Display the email in the app bar
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$useremail',
            style: TextStyle(fontSize: 20),
          ),
          TextFormField(
            controller: message,
          ),
          TextButton(
              onPressed: () {
                sendMessage();
              },
              child: Text('send message')),
          _buildMessageItem(),
        ],
      ),
    );
  }

  Widget _buildMessageItem() {
    return StreamBuilder(
      stream: ChatService()
          .getMessage(receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading....');
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageList(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  Widget _buildMessageList(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    // Check if data is not null before accessing its properties
    if (data != null) {
      var isSender = (data['senderId'] == _firebaseAuth.currentUser!.uid);
      var alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;

      return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSender
                    ? Colors.blue
                    : Colors.green, // Customize colors as needed
              ),
              child: Text(data['message'] ?? '',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    // Return an empty Container or another placeholder widget if data is null
    return Container(); // You can customize this to show a loading indicator or something else.
  }
}
