import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:solo_luxury/app/screens/about_us/about_us_screen.dart';
import 'package:solo_luxury/app/screens/home/widget/header_widget.dart';
import 'package:solo_luxury/app/screens/refer_friend/refer_friend_screen.dart';
import 'package:solo_luxury/app/utils/app_asset.dart';
import 'package:solo_luxury/app/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Image.asset(AppAsset.logo, width: 110),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 60),
          child: const HeaderWidget(),
        ),
      ),
      endDrawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(AppAsset.banner),
            ),
            detailsButton('ABOUT US', 1),
            Visibility(
              visible: index == 1 ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => const AboutUsScreen());
                    },
                    child: const Text(
                      'About Us',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => ReferFriendScreen());
                    },
                    child: const Text(
                      'Refer Friend',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Returns & Refunds',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'FAQ       ',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            detailsButton('CONTACT', 2),
            detailsButton('SOCIAL', 3),
            detailsButton('COMPANY', 4),
            const SizedBox(height: 20),
            emailSubscribe(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget detailsButton(String text, int value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == value) {
            index = 0;
          } else {
            index = value;
          }
        });
      },
      child: Container(
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          color: appColor,
          border: Border.all(color: Colors.black, width: 0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.expand_more,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget emailSubscribe() {
    return Container(
      height: 47,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: appColor, width: 1.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Your E-Mail',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 13.5),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 47,
            width: 120,
            decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: appColor, width: 1.5),
            ),
            alignment: Alignment.center,
            child: const Text(
              'SUBSCRIBE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}