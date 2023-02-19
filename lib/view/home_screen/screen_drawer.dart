import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/home_screen/home_screen_controller.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart';
import '../../core/constant.dart';
import '../widgets.dart';
import 'about_home.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({super.key});
  final HomeScreenController _homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  functionText(appName, kWhiteColor, FontWeight.bold, 30),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  functionText(
                      '- A Bhajan Player', kWhiteColor, FontWeight.bold, 20),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 8.0, left:1, right: 10),
                      child: Divider(
                        color: Colors.grey,
                        height: 2,
                        thickness: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Center(
                      child: Image.asset(
                        'assets/images/appIcon.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                  ),
                  SizedBox(height: 300,),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 8.0, left: 30, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AboutHome()),
                          );
                        },
                        child: functionText('About Us', kWhiteColor, FontWeight.bold, 25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                ]
              ),

            ],
          ),

        ),
      ),
    );

  }
}
