import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/colors.dart';
import '../screen_search/screen_search.dart';
import '../screen_search/screen_search1.dart';

class DifficultyHome extends StatefulWidget {
  @override
  _DifficultyPageState createState() => _DifficultyPageState();
}

class _DifficultyPageState extends State<DifficultyHome> {
  List<dynamic> _songs = [];
  List<String> _jsonstr = [];

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/mainjson.json').then((data) {
      List<dynamic> songsJson = json.decode(data) as List<dynamic>;
      _songs = List<dynamic>.from(songsJson);
      _jsonstr = _songs
          .map((song) => song["LANGUAGE"] as String)
          .toSet()
          .toList();
      _jsonstr.sort();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('By Difficulty'),
        backgroundColor: kAppbarColor,
      ),
      body: _jsonstr.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _jsonstr.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 20), // Add a 20-pixel gap at the top
              Padding(padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(color: kAppbarColor),
                alignment: Alignment.center,
                child: ListTile(
                  title: Center(
                    child: Text(
                      _jsonstr[index],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                  ,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongsPage(
                          key: UniqueKey(),
                          jsonstr: _jsonstr[index],
                          songs: _songs
                              .where((song) => song["LANGUAGE"] == _jsonstr[index])
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),),
            ],
          );

        },
      ),
    );
  }
}

class SongsPage extends StatelessWidget {
  final String jsonstr;
  final List<dynamic> songs;

  const SongsPage({
    required Key key,
    required this.jsonstr,
    required this.songs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],

      appBar: AppBar(
        title: Text(jsonstr),
        backgroundColor: kAppbarColor,

      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              String songName = songs[index]['FILE'].toString();
              String finalName = songName.substring(5, songName.length - 4);
              showSearch(
                query: finalName,
                context: context,
                delegate: MusicSearch1(),
              );
            },
            child: Container(
              child: ListTile(
                title: Text(
                  songs[index]['FILE'].toString().substring(5, songs[index]['FILE'].toString().length - 4),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

