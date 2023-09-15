import 'package:chatapp/app/services/chatservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChattingPageController extends GetxController {
  //TODO: Implement ChattingPageController
  final TextEditingController message = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
}
