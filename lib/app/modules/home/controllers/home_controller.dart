import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Define a list to store the user data
  RxList<User> userList = RxList<User>();

  @override
  void onInit() {
    super.onInit();
    // Fetch the list of users when the controller is initialized
    fetchUserList();
  }

  Future<void> fetchUserList() async {
    try {
      // Fetch user data from Firestore collection
      QuerySnapshot userSnapshot = await _firestore.collection('user').get();

      // Clear the existing user list
      userList.clear();

      // Populate the user list with data from Firestore
      userList.addAll(userSnapshot.docs.map((doc) {
        // Convert Firestore data to User object
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        return User.fromMap(userData);
      }));
    } catch (e) {
      print('Error fetching user list: $e');
    }
  }
}

class User {
  final String pass;
  final String email;

  User({required this.pass, required this.email});

  // Factory constructor to create a User object from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      pass: map['name'] ?? '',
    );
  }
}
