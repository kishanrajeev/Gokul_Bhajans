import 'dart:io';
import 'package:flutter/material.dart';
import 'package:external_path/external_path.dart';

import '../../core/colors.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({
    Key? key,
  }) : super(key: key);

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  String _status = '';

  Future<void> deleteFolder() async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete all of the downloaded files? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("CANCEL"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("DELETE"),
            ),
          ],
        );
      },
    );

    if (!confirmed!) {
      return;
    }

    setState(() {
      _status = 'Deleting...';
    });

    final dirPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_MUSIC);

    final gbvsDir = Directory('$dirPath/GokulBhajans');

    if (gbvsDir.existsSync()) {
      gbvsDir.deleteSync(recursive: true);
      print('Deleted $dirPath/GokulBhajans');
    }

    setState(() {
      _status = "";
    });

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Deletion Complete"),
          content: const Text("The extracted files have been deleted."),
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
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CLICKING THE BUTTON BELOW WILL REMOVE ALL OF THE DOWNLOADED FILES. YOU WILL HAVE TO REINSTALL BEFORE YOU CAN USE THIS APP AGAIN',
                style: TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (_status.isNotEmpty) ...[
                Text(
                  _status,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: _status.isNotEmpty ? null : deleteFolder,
                child: const Text('Delete Extracted Files'),
              ),
              SizedBox(height: 30,),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              )

            ],
          ),
        ),
      ),
    );
  }
}
