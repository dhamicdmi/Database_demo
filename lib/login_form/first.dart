import 'dart:io';
import 'dart:math';

// import 'package:camara_pic/view_data.dart';
// import 'package:demo/login_form/second.dart';
import 'package:database_demo/login_form/second.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
{
  runApp(MaterialApp(
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}class first extends StatefulWidget {
  static Directory ? dir;
  static Database ? database;
  Map? l;
  first([this.l]);



  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {


  final ImagePicker picker = ImagePicker();
  XFile? image;
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
  String gender="";
  int city=1;
  bool  t=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    data();
  }
  data()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');


// open the database
    first.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE student1 (id INTEGER PRIMARY KEY, name TEXT,contact TEXT,email TEXT,password TEXT,city TEXT,gender TEXT,image TEXT )');
        });
  }
  get()
  async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    print(path);

    first.dir=Directory(path);
    if(! await first.dir!.exists())
    {
      first.dir!.create();
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Photo Gallary"),
        ),
        body: Column(
            children: [
              TextField(

                controller: t1,
                decoration: InputDecoration(hintText: "Enter Name"),

              ),
              TextField(
                controller: t2,
                decoration: InputDecoration(hintText: "Enter contact"),

              ),
              TextField(
                controller: t3,
                decoration: InputDecoration(hintText: "Enter gmail"),
              ),
              TextField(
                controller: t4,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              StatefulBuilder(builder: (context, setState) {
                return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RadioMenuButton(value: 'male', groupValue: gender, onChanged: (value) {
                      gender=value!;
                      setState(() {

                      });
                    }, child: Text("Male")),
                    RadioMenuButton(value: 'female', groupValue: gender, onChanged: (value) {
                      gender=value!;
                      setState(() {
                      });
                    }, child: Text("Female")),
                  ],
                );
              },),
              DropdownButton(value: city, items:[DropdownMenuItem(child: Text("surat"),value: 1),
                DropdownMenuItem(child: Text("baroda"),value: 2),
                DropdownMenuItem(child: Text("vapi"),value: 3),
                DropdownMenuItem(child: Text("valsad"),value: 4),
                DropdownMenuItem(child: Text("amreli"),value: 5),
                DropdownMenuItem(child: Text("ahemdabad"),value: 6),

              ],onChanged:(value) {
                city=value!;
                setState(() {

                });
              },),
              ElevatedButton(onPressed: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("Choose any one"),
                    actions: [
                      Row(
                        children: [

                          TextButton(onPressed: () async {
                            image = await picker.pickImage(source: ImageSource.camera);
                            t=true;
                            Navigator.pop(context);
                            setState(() {

                            });
                          }, child: Text("Camera")),
                          TextButton(onPressed: () async {
                            image = await picker.pickImage(source: ImageSource.gallery);
                            t=true;
                            Navigator.pop(context);
                            setState(() {

                            });
                          }, child: Text("Gallary"))
                        ],
                      )
                    ],
                  );
                },);
              }, child: Text("Choose")),
              Row(
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      color: Colors.pinkAccent,
                      child: (t)?(image!=null)?Image.file(File(image!.path)):null:null
                  ),
                ],

              ),
              ElevatedButton(onPressed: () async {
                String name=t1.text;
                String contact=t2.text;
                String email=t3.text;
                String password=t4.text;
                int r = Random().nextInt(100);
                String img_name = "${r}img.png";

                File f = File('${first.dir!.path}/${img_name}');
                await f.writeAsBytes(await image!.readAsBytes());
                String qry="insert into student1 values(null,'$name','$contact','$email','$password','$city','$gender','$img_name')";
                first.database!.rawInsert(qry);
                print(qry);


              }, child: Text("Add")),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return view_data();
                },));
              }, child: Text("View"))

            ],
            ),
        );
    }
}
