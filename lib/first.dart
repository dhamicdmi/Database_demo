import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
{
  runApp(MaterialApp(home:first()));
}
class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  // String str="text";
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();

  get()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cdmi.db');
  }
  Widget txt_fun(TextEditingController t,String str)
  {
      return TextField(controller: t,decoration: InputDecoration(hintText: str,border: OutlineInputBorder()),);


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        txt_fun(t1,"Enter Name"),
      txt_fun(t2,"Enter Contact"),
        ElevatedButton(onPressed: () {
          String name=t1.text;
          String contact=t2.text;
          setState(() {});
        }, child: Text("submit")),
      ],),

    );
  }
}
