import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:archive/archive.dart';

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
          child: Text('Download and Extract'),
          onPressed: () => downloadAndExtract(),
        ),
      ),
    );
  }

  void downloadAndExtract() async {
    // Set up the download and extraction directories
    final downloadsDirectory = (await getExternalStorageDirectory())!.path;
    final extractionDirectory =
        '${(await getApplicationDocumentsDirectory()).path}/Gokulbhajans';
    final extractionDir = Directory(extractionDirectory);
    bool hasExtractionDirExisted = await extractionDir.exists();
    if (!hasExtractionDirExisted) {
      extractionDir.create();
    }

    // Download the zip file from the source URL
    final zipUrl =
        'http://drive.google.com/uc?id=1wGDrYfurNHnHyjIzsCaUy2oif3GJKlmB';
    final zipPath = '$downloadsDirectory/music.zip';
    final client = Dio();
    await client.download(zipUrl, zipPath);

    // Extract the contents of the zip file to the extraction directory
    final bytes = File(zipPath).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    for (final file in archive) {
      final filePath = '${extractionDirectory}/${file.name}';
      if (file.isFile) {
        final data = file.content as List<int>;
        final extractedFile = File(filePath);
        await extractedFile.create(recursive: true);
        await extractedFile.writeAsBytes(data);
      } else {
        await Directory(filePath).create(recursive: true);
      }
    }

    // Delete the zip file after successful extraction
    File(zipPath).deleteSync();

    print('Extraction complete');
  }
}
