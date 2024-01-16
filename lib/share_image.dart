import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: share1(),
  ));
}

class share1 extends StatefulWidget {
  const share1({super.key});

  @override
  State<share1> createState() => _share1State();
}

class _share1State extends State<share1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.yellow,
            height: 200,
            width: 200,
            alignment: Alignment.center,
            child: Text(
              "hello",
              style: TextStyle(fontSize: 40),
            ),
          ),
          ElevatedButton(onPressed: () {

          }, child: Text("submit")),
        ],
      ),
    );
  }
}
