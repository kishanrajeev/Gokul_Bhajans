import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newmusicplayer/view/home_screen/singer_home.dart';
import '../../controller/audio_functions.dart';
import '../../controller/home_screen/home_screen_controller.dart';
import '../../controller/playlist_Screen/screen_playlist_controller.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart';
import '../favourite_screen/screen_favourite.dart';
import '../play_screen/screen_play.dart';
import '../playlist_screen/screen_playlist.dart';
import '../screen_search/screen_search.dart';
import '../screen_search/screen_search1.dart';
import '../screen_search/search_screen2.dart';
import '../widgets.dart';
import 'author_home.dart';
import 'catagory_home.dart';
import 'delete.dart';
import 'difficulty_page.dart';
import 'downlaod.dart';
import 'language_page.dart';
import 'screen_home_bottomsheet.dart';
import 'title_page.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final HomeScreenController _homeScreenController =
  Get.put(HomeScreenController());

  final PlaylistController _playlistController = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    return allAudioListFromDB.isEmpty
        ? Container(
        padding: EdgeInsets.only(top: 200, bottom: 10.0, right: 20, left: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DownloadPage()),
                    );
                  },

                  child: Text('Please Download The Bhajans First'),
                ),
              ),
            ),

          ],
        )
    )

        : Container(
        padding: EdgeInsets.only(top: 200, bottom: 10.0, right: 20, left: 20),
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScreenTitle()),
                          );
                        },
                        child: Text('By Title'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CatagoryHome()),
                          );
                        },
                        child: Text('By Theme'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SingerHome()),
                          );
                        },
                        child: Text('By Singer'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AuthorHome()),
                          );
                        },
                        child: Text('By Author'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LanguageHome()),
                          );
                        },
                        child: Text('By Language'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DifficultyHome()),
                          );
                        },
                        child: Text('By Difficulty'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-a',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('A'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-b',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('B'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-c',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('C'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-d',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('D'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-e',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('E'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-f',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('F'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-g',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('G'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-h',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('H'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-i',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('I'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-j',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('J'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-k',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('K'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-l',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('L'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-m',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('M'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-n',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('N'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-o',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('O'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-p',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('P'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-q',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('Q'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-r',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('R'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-s',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('S'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-t',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('T'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-u',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('U'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-v',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('V'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-w',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('W'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-x',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('X'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          showSearch(
                            query: '-y',
                            context: context,
                            delegate: MusicSearch2(),
                          );
                        },
                        child: Text('Y'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DownloadPage()),
                          );
                        },

                        child: Text('Download Files'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: kAppbarColor, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DeletePage()),
                          );
                        },

                        child: Text('Delete Files'),
                      ),
                    ),
                  ),
                ],
              ),

            ]
        )
    );


  }
}