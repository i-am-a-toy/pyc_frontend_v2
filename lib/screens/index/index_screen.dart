import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/controllers/index/fetch_me_controller.dart';
import 'package:pyc/screens/index/components/index_drawer.dart';
import 'package:pyc/screens/index/components/index_profile.dart';

class IndexScreen extends StatelessWidget {
  static String routeName = '/index';
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/icons/index_hamburger.png'),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: GetBuilder<FetchMeController>(
        builder: (controller) => IndexDrawer(
          name: controller.myProfile.name,
          size: MediaQuery.of(context).size,
        ),
      ),
      body: GetBuilder<FetchMeController>(
        builder: (controller) => controller.isLoading
            ? const ShimmerIndexUserProfile()
            : IndexProfile(
                image: controller.myProfile.image,
                name: controller.myProfile.name,
                role: controller.myProfile.role,
              ),
      ),
    );
  }
}
