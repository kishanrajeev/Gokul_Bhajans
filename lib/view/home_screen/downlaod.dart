import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';

class Download extends StatefulWidget {
  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  String _filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Download File'),
              onPressed: () {
                downloadFile().then((filePath) {
                  setState(() {
                    _filePath = filePath;
                  });
                });
              },
            ),
            SizedBox(height: 16),
            if (_filePath.isNotEmpty) Text('File saved to: $_filePath'),
          ],
        ),
      ),
    );
  }

  Future<String> downloadFile() async {
    String url = 'http://drive.google.com/uc?id=1wGDrYfurNHnHyjIzsCaUy2oif3GJKlmB'; // Replace with your URL
    String fileName = 'music.zip'; // Replace with your file name
    String dir = (await getExternalStorageDirectory())!.path;
    String filePath = '';

    HttpClient httpClient = HttpClient();

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();

      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        File file = File(filePath);
        await file.writeAsBytes(bytes);

        // Extract the file
        var archive = ZipDecoder().decodeBytes(bytes);
        for (var file in archive) {
          var filename = '$dir/${file.name}';
          if (file.isFile) {
            var outFile = File(filename);
            outFile = await outFile.create(recursive: true);
            await outFile.writeAsBytes(file.content as List<int>);
          } else {
            await Directory(filename).create(recursive: true);
          }
        }
      } else {
        filePath = 'Error code: ' + response.statusCode.toString();
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }
}
