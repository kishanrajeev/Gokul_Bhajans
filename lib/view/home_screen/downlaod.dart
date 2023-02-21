import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';


class Download extends StatefulWidget {
  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Download Music'),
          onPressed: () => downloadFolder(),
        ),
      ),
    );
  }

  void downloadFolder() async {
    // Initialize dio with your OneDrive API credentials
    var dio = Dio(BaseOptions(
      headers: {'Authorization': 'Bearer YOUR_ACCESS_TOKEN'},
    ));

    // Set up the download directory
    final directory = await getExternalStorageDirectory();
    final downloadsDirectory = '${directory?.path}/Downloads';
    final savedDir = Directory(downloadsDirectory);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    // Download the folder from OneDrive and save it to local storage
    try {
      final response = await dio.download(
        'https://graph.microsoft.com/v1.0/me/drive/root:/Music',
        '${downloadsDirectory}/Music.zip',
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + '%');
          }
        },
      );
      print(response.statusCode);
      final taskId = await FlutterDownloader.enqueue(
        url: 'https://graph.microsoft.com/v1.0/me/drive/root:/Music',
        savedDir: downloadsDirectory,
        fileName: 'Music.zip',
        showNotification: true,
        openFileFromNotification: true,
      );
      print('Download task ID: $taskId');
    } catch (e) {
      print(e);
    }
  }
}