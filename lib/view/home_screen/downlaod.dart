import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:archive/archive.dart';
import 'package:external_path/external_path.dart';
import 'package:media_scanner_scan_file/media_scanner_scan_file.dart';

import '../../core/colors.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DownloadPage> createState() => _SingleDownloadScreenState();
}

class _SingleDownloadScreenState extends State<DownloadPage> {
  final String url =
      "https://bkdasa.synology.me:2061/gokulbhajans/data/test.zip"; // Change this to your desired URL
  double? _progress;
  String _status = '';


  Future<void> extractZip(String filePath) async {
    setState(() {
      _status = 'Extracting...';
    });

    // Read the Zip file from disk.
    final bytes = File(filePath).readAsBytesSync();

    // Decode the Zip file
    final archive = ZipDecoder().decodeBytes(bytes);

    // Get the Downloads directory
    final dirPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_MUSIC);

    // Create the GBVS folder inside the Documents folder
    final gbvsDir = Directory('$dirPath/GokulBhajans');
    gbvsDir.createSync();

    // Extract the contents of the Zip archive to the GBVS folder.
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        final filePath = '$dirPath/GokulBhajans/${filename.split('/').last}';
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);

        try {
          final result = await MediaScannerScanFile.scanFile(filePath);
          print('Scan result: $result');
          final String? mediaPath = result['filePath'] as String?;
          print('Scanned file path: $mediaPath');
        } catch (e) {
          print('Error scanning file: $e');
        }
      }
    }

    // Delete the original zip file
    await File(filePath).delete();

    print('Extracted files to $dirPath/GokulBhajans');

    setState(() {
      _status = "";
      _progress = null;
    });

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Downloading Complete"),
          content: const Text("Please restart the app once it exits."),
          actions: [
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('GokulBhajans Downloader')),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Please do not leave the app before the downloading bar disappears. It may appear to be stuck, but please be patient.',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Please be sure to use the "Delete Files" Button before permanently uninstalling the app to delete the music files and save storage.',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      if (_progress != null) ...[
                        Text(_status, style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 20),
                        LinearProgressIndicator(value: _progress),
                        const SizedBox(height: 20),
                      ],
                      ElevatedButton(
                        onPressed: _progress != null
                            ? null
                            : () async {
                          setState(() {
                            _status = "Downloading...";
                          });
                          final dirPath = await ExternalPath
                              .getExternalStoragePublicDirectory(
                              ExternalPath.DIRECTORY_MUSIC
                          );
                          final downPath = await ExternalPath
                              .getExternalStoragePublicDirectory(
                              ExternalPath.DIRECTORY_DOWNLOADS
                          );
                          print(downPath);
                          final filePath = File('$downPath/GokulBhajans.zip');
                          if (filePath.existsSync()) {
                            await filePath.delete();
                          }

                          FileDownloader.downloadFile(
                            url: url,
                            name: 'GokulBhajans.zip',
                            onProgress: (name, progress) {
                              setState(() {
                                _progress = progress / 100;
                              });
                            },
                            onDownloadCompleted: (value) async {
                              print('path $value');
                              await extractZip(value);
                            },
                          );
                        },
                        child: const Text('Download Bhajans'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}