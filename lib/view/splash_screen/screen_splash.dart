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
  bool _isFirstLaunch = true;

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
    await prefs.setBool('is_first_launch', false);

    if (_isFirstLaunch) {
      // Ask for read and write permissions
      if (!(await Permission.storage.isGranted)) {
        await Permission.storage.request();
      }
      Get.off(() => InDownloadPage());
    } else {
      await _screenSplashController.gotoHome(context);
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
