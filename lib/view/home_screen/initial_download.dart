import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:archive/archive.dart';
import 'package:external_path/external_path.dart';
import 'package:media_scanner_scan_file/media_scanner_scan_file.dart';

import '../../core/colors.dart';

class InDownloadPage extends StatefulWidget {
  const InDownloadPage({
    Key? key,
  }) : super(key: key);

  @override
  State<InDownloadPage> createState() => _SingleDownloadScreenState();
}

class _SingleDownloadScreenState extends State<InDownloadPage> {
  final List<String> urls = [
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133810&authkey=!AJl_l6B0L--wyAc",  //"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114910&authkey=AOtKN7rQOBPVe9A", // URL 1
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B!33812&authkey=!AHEgu04o0u7YePA",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114911&authkey=ABcUkgf9iMpAZ_k", // URL 2
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133809&authkey=!ADyaURyLCbftc10",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114909&authkey=AO_DEAyqrBTzlF8", // URL 3
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133811&authkey=!ADIPg996MymIQBk",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114912&authkey=ADPG7V9RFoNxEZo", // URL 4
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133813&authkey=!AHo3wfX0AfWeyW4",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114917&authkey=AAWmZ9Wvk4N4KaE", // URL 5
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133814&authkey=!APHBLJ_HeG-OEqk",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114914&authkey=AM3KvAXPK24AxX0", // URL 6
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133827&authkey=!ANRtOHdy6nZETHE",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114913&authkey=APX-98VFTzEY5qY", // URL 7
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133817&authkey=!AOl3W2OPGWqAUXA",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114915&authkey=ANaImqZ2FPiIDM4", // URL 8
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133818&authkey=!AOnQbobTrGMJ1yM",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114918&authkey=AGUvylyFEj6uigU", // URL 9
    "https://onedrive.live.com/download?resid=4493F08A0F8CBA8B%2133820&authkey=!AAAEDv-p0FNwaNQ",//"https://onedrive.live.com/download?cid=4493F08A0F8CBA8B&resid=4493F08A0F8CBA8B%2114916&authkey=APrUFYmyhds1u8M", // URL 10
  ];  // URLs to download
  double? _progress;
  String _status = '';
  int testnum = 1;
  int amountofurls = 0; // number of URLs in the list will be automatically detected later
  @override
  void initState() {
    super.initState();
    amountofurls = urls.length;
  }
  Future<void> extractZip(String filePath) async {
    setState(() {
      _status = 'Extracting...';
      _progress = 75;
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
        final chunks = <Uint8List>[];
        final chunkSize = 1024 * 1024;
        var offset = 0;
        while (offset < data.length) {
          final chunk = Uint8List.fromList(
              data.sublist(offset, offset + chunkSize > data.length ? data.length : offset + chunkSize));
          chunks.add(chunk);
          offset += chunk.lengthInBytes;
        }
        final filePath = '$dirPath/GokulBhajans/${filename.split('/').last}';
        await File(filePath).writeAsBytes(chunks.expand((x) => x).toList());

        try {
          final result = await MediaScannerScanFile.scanFile(filePath);
          print('Scan result: $result');
          final String? mediaPath = result['filePath'] as String?;
          print('Scanned file path: $mediaPath');
        } catch (e) {
          print('Error scanning file: $e');
          setState(() {
            _status = 'Scanning...';
          });

        }
      }
    }
    if (testnum == amountofurls) {
      print('Test number: $testnum COMPLETED');
      setState(() {
        _status = "DOWNLOAD COMPLETE";
        _progress = 100;
      });
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Downloading Complete"),
            content:
            const Text("Please restart the app once it exits."),
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

    } else {
      testnum = testnum + 1;
      print('Test number: $testnum');

    }

    // Delete the original zip file
    await File(filePath).delete();
    print('Extracted files to $dirPath/GokulBhajans');

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
                        'Please be sure to use the "Delete Files" Button before permanently uninstalling the app to delete the music files and save storage.' ,
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
                          final dirPath = await ExternalPath.getExternalStoragePublicDirectory(
                              ExternalPath.DIRECTORY_MUSIC);
                          final downPath = await ExternalPath.getExternalStoragePublicDirectory(
                              ExternalPath.DIRECTORY_DOWNLOADS);
                          print(downPath);

                          for (String url in urls) {
                            final filePath = File('$downPath/GokulBhajans.zip');
                            if (filePath.existsSync()) {
                              try {
                                //await MediaScannerScanFile.scanFile('$downPath/GokulBhajans.zip');
                                await filePath.delete();
                              } catch (e) {
                              }
                            }

                            await FileDownloader.downloadFile(
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
                          }

                          // Show the dialog after all extractions have been completed

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