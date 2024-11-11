import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_designer/story_designer.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? edited;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Designer Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                final picker = ImagePicker();
                await picker
                    .pickImage(source: ImageSource.gallery)
                    .then((file) async {
                  if (file != null) {
                    File editedFile = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StoryDesigner(
                          filePath: file.path,
                        ),
                      ),
                    );
                    // ------- you have editedFile

                    print('editedFile: ' + editedFile.path);
                    setState(() {
                      edited = editedFile;
                    });
                  }
                });
              },
              child: const Text('Pick Image'),
            ),
            if (edited != null)
              Expanded(
                child: Image.file(
                  edited!,
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
