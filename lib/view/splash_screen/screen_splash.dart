import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart';
import '../../core/constant.dart';
import '../home_screen/downlaod.dart';
import '../home_screen/home_widgets.dart';
import '../home_screen/initial_download.dart';
import '../widgets.dart';


class ScreenSplash extends StatefulWidget {
  ScreenSplash({Key? key}) : super(key: key);

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  late ScreenSplashController _screenSplashController;
  bool _isFirstLaunch = false;

  @override
  void initState() {
    super.initState();
    _screenSplashController = Get.put(ScreenSplashController());
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstLaunch = prefs.getBool('is_first_launch') ?? true;
    });

// Request permission until it is granted or permanently denied
    PermissionStatus permissionStatus = await Permission.storage.request();
    while (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await Permission.storage.request();
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      // Permission permanently denied, prompt user to manually grant permission
      await showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Permissions Required'),
              content: const Text(
                  'Please grant storage permissions to use this app.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () => exit(0),
                ),
                TextButton(
                  child: const Text('SETTINGS'),
                  onPressed: () => openAppSettings(),
                ),
              ],
            ),
      );
    }

    if (!_isFirstLaunch) {
      await _screenSplashController.gotoHome(context);
    } else {
      Get.off(() => InDownloadPage());
      await prefs.setBool('is_first_launch', false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              functionText(
                appName,
                kWhiteColor,
                FontWeight.bold,
                48,
              ),
              functionText(
                '- A Bhajan Player',
                kWhiteColor,
                FontWeight.bold,
                24,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              const CircularProgressIndicator(
                color: kWhiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
