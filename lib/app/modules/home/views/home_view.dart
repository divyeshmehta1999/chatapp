import 'package:chatapp/app/modules/CHATTING_PAGE/views/chatting_page_view.dart';
import 'package:chatapp/app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.userList.length,
              itemBuilder: (context, index) {
                final user = controller.userList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(ChattingPageView('', ''),
                        arguments: {'receiverid': '', 'useremail': ''});
                  },
                  child: ListTile(
                    title: Text(user.pass),
                    subtitle: Text(user.email),
                  ),
                );
              },
            ),
            TextButton(
                onPressed: () {
                  Auth().logOutUser();
                },
                child: Text('logout'))
          ],
        );
      }),
    );
  }
}
