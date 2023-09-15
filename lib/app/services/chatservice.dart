import 'package:chatapp/app/services/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentuserId = _firebaseAuth.currentUser!.uid;
    final String currentuserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentuserId,
        receiverId: receiverId,
        senderEmail: currentuserEmail,
        message: message,
        timestamp: timestamp);
    List<String> ids = [currentuserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection('chatrooms')
        .doc('chatRoomId')
        .collection('message')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chatrooms')
        .doc('chatRoomId')
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
