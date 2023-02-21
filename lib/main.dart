import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/music_model.dart';
import 'view/splash_screen/screen_splash.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

late Box<List<MusicModel>> musicDB;
late Box<List<String>> favouriteDB;
late Box<List<String>> playlistDB;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MusicModelAdapter().typeId)) {
    Hive.registerAdapter(MusicModelAdapter());
  }

  musicDB = await Hive.openBox('music_db');
  favouriteDB = await Hive.openBox('favourite_box');
  playlistDB = await Hive.openBox('playlist_box');

  // Extract .obb file to temporary directory
  await extractObbFile();

  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}

// Extract .obb file to temporary directory
Future<void> extractObbFile() async {
  final packageName = 'com.igokulam.gokul_bhajans'; // Replace with your app's package name
  final obbFilePath = '/Android/obb/$packageName/my_app.obb';
  final obbFile = File('$obbFilePath');
  final exists = await obbFile.exists();
  if (!exists) {
    // .obb file not found, return early or show an error message
    return;
  }
  final bytes = await obbFile.readAsBytes();
  final extractedObbFile = File('${(await getTemporaryDirectory()).path}/my_app.obb');
  await extractedObbFile.writeAsBytes(bytes);
  // Use the extracted obb file as needed.
}


