import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/audio_functions.dart';
import '../../controller/home_screen/home_screen_controller.dart';
import '../../controller/playlist_Screen/screen_playlist_controller.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart';
import '../favourite_screen/screen_favourite.dart';
import '../play_screen/screen_play.dart';
import '../playlist_screen/screen_playlist.dart';
import '../screen_search/screen_search.dart';
import '../widgets.dart';
import 'home_widgets.dart';
import 'screen_home_bottomsheet.dart';
import 'title_page.dart';

class AboutHome extends StatelessWidget {
  AboutHome({super.key});

  final HomeScreenController _homeScreenController =
  Get.put(HomeScreenController());

  final PlaylistController _playlistController = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: kAppbarColor,
        title: Text('About Us'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'About Gokul Bhajan and Vedic Studies',
              style: TextStyle(fontSize: 32,color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
                "Gokul Bhajan & Vedic Studies is an independent, registered 501(c) non-profit religious organization. Our programs are designed for the whole family to engage in blissful devotional life with Lord Krishna as the center of our lives. We follow Lord Caitanya Mahaprabhu in the line of six goswamis under Sri Brahma Madhva Gaudiya Sampradaya. We are not affiliated or controlled by any organization. Our organization also runs flagship community projects, such as a prison ministry that transforms the lives of many. We have more than 750 prisons, and a total of nearly 1700 prison inmates participate in our programs. Additionally, we are an agency that awards Presidential Awards for all our community services!",
              style: TextStyle(fontSize: 18,color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.grey,
              height: 5,
              thickness: 2,
            ),
            SizedBox(height: 20.0),
            Text(

              'Developed By: Kishan Rajeev Jagadeesh',
              style: TextStyle(fontSize: 10,color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(

              'Under Guidance From: Dr. Bhagavati Kanta Dasa',
              style: TextStyle(fontSize: 10,color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}