import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../controller/favorite_screen/screen_favourites_controller.dart';
import '../../controller/play_screen/screen_play_controller.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart';
import '../playlist_screen/screen_add_to_playlist.dart';
import '../widgets.dart';

RealtimePlayingInfos? realtimePlayingInfos1;

class ScreenPlay extends StatelessWidget {
  const ScreenPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Now Playing'),
        centerTitle: true,
      ),
      body: audioPlayer.builderRealtimePlayingInfos(builder:
          (BuildContext contex, RealtimePlayingInfos realtimePlayingInfos) {
        realtimePlayingInfos1 = realtimePlayingInfos;
        return PlayContainer();
      }),
    );
  }
}

class PlayContainer extends StatefulWidget {
  @override
  _PlayContainerState createState() => _PlayContainerState();
}

class _PlayContainerState extends State<PlayContainer> {
  final ScreenPlayController screenPlayController =
  Get.put(ScreenPlayController());
  final FavouritesController favouritesController =
  Get.put(FavouritesController());

  late Future<String> textDataFuture; // Declare the future for text data

  @override
  void initState() {
    super.initState();
    textDataFuture = loadTextData(context); // Load text data only once

  }

  Future<String> loadTextData(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 300));
    String? title = realtimePlayingInfos1!.current!.audio.audio.metas.title.toString();
    String first4 = title!.substring(0, 4);
    String textData =
    await DefaultAssetBundle.of(context).loadString('assets/bhajan-lyrics/$first4.txt');
    return textData;
  }


  Widget _buildMarquee(String text) {
    return Marquee(
      text: text,
      style: const TextStyle(color: kWhiteColor),
      blankSpace: 50,
    );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: textDataFuture, // Use the pre-loaded future
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String textData = snapshot.data!;
          String? title = realtimePlayingInfos1!.current!.audio.audio.metas.title.toString();
          String first4 = title!.substring(0, 4);
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 15,
                          blurRadius: 30,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      width: Get.width * 0.85,
                      height: Get.height * 0.40,
                      child: SingleChildScrollView(
                        child: Text(
                          textData,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                      height: Get.height * 0.03,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 7),
                      child: _buildMarquee(
                        realtimePlayingInfos1!.current!.audio.audio.metas
                            .title
                            .toString(),
                      )),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            if (tempFavouriteList.contains(
                                realtimePlayingInfos1!
                                    .current!.audio.audio.metas.id)) {
                              favouritesController.favouritesRemove(
                                  realtimePlayingInfos1!.current!.audio.audio
                                      .metas.id
                                      .toString());
                            } else {
                              favouritesController.addFavouritesToDB(
                                  realtimePlayingInfos1!.current!.audio.audio
                                      .metas.id
                                      .toString());
                            }
                          },
                          icon: tempFavouriteList.contains(
                              realtimePlayingInfos1!
                                  .current!.audio.audio.metas.id)
                              ? functionIcon(Icons.favorite, 30, kRoseColor)
                              : functionIcon(
                              Icons.favorite, 30, Colors.white)),
                      IconButton(
                        onPressed: () {
                          if (screenPlayController.loopButton.value) {
                            audioPlayer.setLoopMode(LoopMode.single);
                            screenPlayController.loopButton.value = false;
                          } else {
                            audioPlayer.setLoopMode(LoopMode.none);
                            screenPlayController.loopButton.value = true;
                          }
                        },
                        icon: Obx(
                              () {
                            return screenPlayController.loopButton.value
                                ? functionIcon(Icons.repeat, 35, kWhiteColor)
                                : functionIcon(
                                Icons.repeat_one, 35, kWhiteColor);
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: kBackgroundColor2,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return ScreenAddToPlaylistFromHome(
                                    id: realtimePlayingInfos1!
                                        .current!.audio.audio.metas.id
                                        .toString(),
                                  );
                                });
                          },
                          icon: functionIcon(
                              Icons.playlist_play, 35, kWhiteColor))
                    ],
                  ),
                  slider(realtimePlayingInfos1!),
                  Container(
                    transform: Matrix4.translationValues(0, -5, 0),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                    child: timeStamps(realtimePlayingInfos1!),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          if (songSkip) {
                            songSkip = false;
                            await audioPlayer.previous();
                            songSkip = true;
                          }
                        },
                        child: functionIcon(
                            Icons.skip_previous, 55, Colors.white),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          audioPlayer.playOrPause();
                        },
                        child: realtimePlayingInfos1!.isPlaying
                            ? functionIcon(Icons.pause, 55, Colors.white)
                            : functionIcon(
                            Icons.play_arrow_rounded, 55, Colors.white),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          if (songSkip) {
                            songSkip = false;
                            await audioPlayer.next();
                            songSkip = true;
                          }
                        },
                        child: functionIcon(
                            Icons.skip_next, 55, Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      });
  }


}




