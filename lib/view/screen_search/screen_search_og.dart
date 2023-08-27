import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/audio_functions.dart';
import '../../controller/home_screen/home_screen_controller.dart';
import '../../controller/playlist_Screen/screen_playlist_controller.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart';
import '../../model/music_model.dart';
import '../favourite_screen/screen_favourite.dart';
import '../home_screen/screen_home_bottomsheet.dart';
import '../play_screen/screen_play.dart';
import '../widgets.dart';
import 'package:external_path/external_path.dart';



class MusicSearch extends SearchDelegate<dynamic> {
  @override
  final HomeScreenController _homeScreenController =
  Get.put(HomeScreenController());
  final PlaylistController _playlistController = Get.put(PlaylistController());
  final String songsDirectoryPath = '/storage/emulated/0/Music/GokulBhajans';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<MusicModel> allAudioListFromDB = fetchSongsFromDirectory();

    final List<MusicModel> suggestionList = allAudioListFromDB
        .where((MusicModel element) =>
        element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return suggestionList.isEmpty
        ? Container(
      color: Colors.black,
      child: const Center(
        child: Text(
          'No Results Found',
          style: TextStyle(color: Colors.white),
        ),
      ),
    )
        : Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: kColorListTile,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage:
                AssetImage('assets/images/musicIcon1.png'),
              ),
              title: Text(
                suggestionList[index].title.toString(),
                maxLines: 1,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              subtitle: Text(
                suggestionList[index].artist.toString(),
                maxLines: 1,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              trailing: IconButton(
                icon: functionIcon(Icons.more_horiz, 20, Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: kBackgroundColor2,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (BuildContext ctx) {
                        return HomeBottomSheet(
                          id: suggestionList[index].id.toString(),
                        );
                      });
                  favouritesAudioListUpdate = false;
                  _playlistController.playlistAudioListUpdate = false;
                },
              ),
              onTap: () async {
                await createAudiosFileList(suggestionList);
                audioPlayer.playlistPlayAtIndex(index);
                _homeScreenController.miniPlayerVisibility.value = true;
                favouritesAudioListUpdate = false;
                _playlistController.playlistAudioListUpdate = false;

                await Get.to(const ScreenPlay());
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<MusicModel> allAudioListFromDB = fetchSongsFromDirectory();

    final List<MusicModel> suggestionList = allAudioListFromDB
        .where((MusicModel element) =>
        element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: kColorListTile,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/musicIcon1.png'),
              ),
              title: Text(
                suggestionList[index].title.toString(),
                maxLines: 1,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              subtitle: Text(
                suggestionList[index].artist.toString(),
                maxLines: 1,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              trailing: IconButton(
                icon: functionIcon(Icons.more_horiz, 20, Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: kBackgroundColor2,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (BuildContext ctx) {
                        return HomeBottomSheet(
                          id: suggestionList[index].id.toString(),
                        );
                      });
                  favouritesAudioListUpdate = false;
                  _playlistController.playlistAudioListUpdate = false;
                },
              ),
              onTap: () async {
                await createAudiosFileList(suggestionList);
                audioPlayer.playlistPlayAtIndex(index);
                _homeScreenController.miniPlayerVisibility.value = true;
                favouritesAudioListUpdate = false;
                _playlistController.playlistAudioListUpdate = false;

                await Get.to(const ScreenPlay());
              },
            ),
          );
        },
      ),
    );
  }


  List<MusicModel> fetchSongsFromDirectory() {
    // Get a list of files in the specific directory
    Directory songsDirectory = Directory(songsDirectoryPath);
    List<FileSystemEntity> files = songsDirectory.listSync();

    // Filter the files to include only audio files
    List<File> audioFiles = files
        .where((file) => file is File && file.path.endsWith('.mp3'))
        .map((file) => file as File)
        .toList();
    print(files);

    // Convert the audio files to MusicModel objects
    List<MusicModel> songs = audioFiles.map((file) {
      String title = file.path.split('/').last;
      return MusicModel(title: title, artist: 'Unknown');

    }).toList();

    return songs;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: kAppbarColor),
      textTheme: const TextTheme(headline6: TextStyle(color: Colors.white)),
      textSelectionTheme:
      const TextSelectionThemeData(cursorColor: Colors.white),
      hintColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
    );
  }
}
