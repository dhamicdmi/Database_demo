import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool t=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.yellow,
            child: (t)?Image.file(File(image!.path)):null,
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        Row(
                          children: [
                            TextButton(onPressed: () async {
                              image = await picker.pickImage(source: ImageSource.camera);
                              t=true;
                              Navigator.pop(context);
                              setState(() {});

                            }, child: Text("camera")),
                            TextButton(onPressed: () async {
                              image = await picker.pickImage(source: ImageSource.gallery);
                              t=true;
                              Navigator.pop(context);
                              setState(() {

                              });

                            }, child: Text("gallery")),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              child: Text("choose")),
        ],
      ),
    );
  }
}
