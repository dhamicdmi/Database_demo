import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:database_demo/login_form/view_data.dart';
// import 'package:demo/login_form/view_data.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:widgets_to_image/widgets_to_image.dart';


void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: device_img(),
  ));
}

class device_img extends StatefulWidget {
  // const device_img({super.key});
  static Database? database;
  static Directory? dir;

  Map? l;
  device_img([this.l]);

  @override
  State<device_img> createState() => _device_imgState();
}

class _device_imgState extends State<device_img> {

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  // TextEditingController dateCtl = TextEditingController();
  WidgetsToImageController controller = WidgetsToImageController();
  String type="";
  // String city="1";
  String city="surat";
  XFile? image;
  bool t= false;
  Uint8List? bytes;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    get1();
    if(widget.l != null)
    {
      t1.text = widget.l!['name'];
      t2.text = widget.l!['contact'];
      t3.text = widget.l!['email'];
      t4.text = widget.l!['password'];
      type = widget.l!['gender'];
      city = widget.l!['city'];
      // Image.file(File(image!.path));
      // image = widget.l!['img'];
      // File f= widget.l!['img'];
      setState(() { });
    }
  }

  get()
  async {

    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);

    }


    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/photo";
    print(path);

    device_img.dir=Directory(path);
    if(! await device_img.dir!.exists())
    {
      device_img.dir!.create();
    }

  }

  get1()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pic.db');      //path package for join

    // open the database
    device_img.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE image_pic (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,contact TEXT,email TEXT,password TEXT,gender TEXT,city TEXT,img TEXT)');
        });
    // setState(() { });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("DATA_INSERT_SQFLITE",style: TextStyle(fontSize: 20,color: Colors.black)),
              backgroundColor: Colors.lime.shade200,
              centerTitle: true,
            ),
            body: Column(children: [
              Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.lightBlueAccent,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/background.jpg")),
                    // ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.all(70),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(60),bottomRight: Radius.circular(60)),
                          border: Border.all(color: Colors.white,style: BorderStyle.solid,width: 3)
                      ),
                      child: Column(children: [
                        Expanded(
                          child: TextFormField(
                            // initialValue: "${formatter}",
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            controller: t1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              // labelText: 'Enter name',labelStyle: TextStyle(color: Colors.grey.shade600),
                              hintText: 'Enter name',hintStyle: TextStyle(color: Colors.grey.shade600),
                              // label: Text("${formatter}"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: "${formatter}",
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            controller: t2,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              // labelText: 'Enter contact',labelStyle: TextStyle(color: Colors.grey.shade600),
                              hintText: 'Enter contact',hintStyle: TextStyle(color: Colors.grey.shade600),
                              // label: Text("${formatter}"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: "${formatter}",
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            controller: t3,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              // labelText: 'Enter email',labelStyle: TextStyle(color: Colors.grey.shade600),
                              hintText: 'Enter email',hintStyle: TextStyle(color: Colors.grey.shade600),
                              // label: Text("${formatter}"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: "${formatter}",
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            controller: t4,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              // labelText: 'Enter password',labelStyle: TextStyle(color: Colors.grey.shade600),
                              hintText: 'Enter password',hintStyle: TextStyle(color: Colors.grey.shade600),
                              // label: Text("${formatter}"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: StatefulBuilder(builder: (context, setState) {
                            return Expanded(
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                Text("gender : ",style: TextStyle(color: Colors.grey.shade600),),
                                Radio(value: "male", groupValue: type, onChanged: (value) {
                                  type=value!;
                                  // total=0;
                                  setState(() { });
                                },),
                                Text("Male",style: TextStyle(color: Colors.white)),
                                Radio(value: "female", groupValue: type, onChanged: (value) {
                                  type=value!;
                                  // total=0;
                                  // dis=(total*10~/100);
                                  setState(() { });
                                },),
                                Text("Female",style: TextStyle(color: Colors.white)),
                              ],),
                            );
                          },),
                        ),
                        Expanded(
                          child: DropdownButton(
                            dropdownColor: Colors.black,
                            style: TextStyle(color: Colors.white),
                            value: city,
                            items: [
                              DropdownMenuItem(child: Text("surat",),value: "surat",),
                              DropdownMenuItem(child: Text("rajkot"),value: "rajkot",),
                              DropdownMenuItem(child: Text("junagadh"),value: "junagadh",),
                              DropdownMenuItem(child: Text("vadodara"),value: "vadodara",),
                              DropdownMenuItem(child: Text("bharuch"),value: "bharuch",),
                              DropdownMenuItem(child: Text("Amadavad"),value: "Amadavad",),
                              DropdownMenuItem(child: Text("bhavanagar"),value: "bhavanagar",),
                            ],
                            onChanged: (value)
                            {
                              city = value!;
                              setState(() { });
                            },),
                        ),
                        Expanded(flex: 2,child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          Expanded(
                            child: Container(
                              width: 200,height: 500,
                              color: Colors.grey,
                              child: (t)?(image!="")?Image.file(fit: BoxFit.fill,File(image!.path)):null:null,
                            ),
                          ),
                          Text("  "),
                          Expanded(
                            child: ElevatedButton(onPressed: () {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: Text("Choose any one"),
                                  actions: [
                                    TextButton(onPressed: () async {
                                      image = await picker.pickImage(source: ImageSource.camera);
                                      print(image);
                                      t=true;
                                      Navigator.pop(context);
                                      setState(() { });
                                    }, child: Text("Camera")),
                                    TextButton(onPressed: () async {
                                      image = await picker.pickImage(source: ImageSource.gallery);
                                      print(image);
                                      t=true;
                                      Navigator.pop(context);
                                      setState(() { });
                                    }, child: Text("Gallery"))
                                  ],
                                );
                              },);
                            },
                                child: Text("Choose")),
                          ),
                        ],)),
                        // Expanded(
                        //   child: WidgetsToImage(
                        //   controller: controller,
                        //   child: (t)?Container(
                        //     width: 100,height: 500,
                        //     color: Colors.grey,
                        //     child: (t)?Image.file(fit: BoxFit.fill,File(image!.path)):null,
                        //   ):null,
                        //  ),
                        // ),
                        // Expanded(child: SizedBox(height: 1,)),
                        // Expanded(
                        //   child: ElevatedButton(onPressed: () {
                        //   showDialog(context: context, builder: (context) {
                        //     return AlertDialog(
                        //       title: Text("Choose any one"),
                        //       actions: [
                        //         TextButton(onPressed: () async {
                        //           image = await picker.pickImage(source: ImageSource.camera);
                        //           print(image);
                        //           t=true;
                        //           Navigator.pop(context);
                        //           setState(() { });
                        //         }, child: Text("Camera")),
                        //         TextButton(onPressed: () async {
                        //           image = await picker.pickImage(source: ImageSource.gallery);
                        //           print(image);
                        //           t=true;
                        //           Navigator.pop(context);
                        //           setState(() { });
                        //         }, child: Text("Gallery"))
                        //       ],
                        //     );
                        //   },);
                        // },
                        //       child: Text("Choose")),
                        // ),
                        // Expanded(child: SizedBox(height: 1,)),
                        Expanded(child: Text("")),
                        Expanded(child: Row(children: [
                          Expanded(flex: 1,
                              child: ElevatedButton(onPressed: () async {

                                int random=Random().nextInt(100);
                                String imag_name="${random}.png";
                                File f = File("${device_img.dir!.path}/${imag_name}");
                                await f.writeAsBytes(await image!.readAsBytes());

                                // print("image path:${f.path}");
                                // print("image :${image!.path}");
                                // Share.shareXFiles([XFile('${f.path}')], text: 'Great picture');

                                String name=t1.text;
                                String contact=t2.text;
                                String email=t3.text;
                                String password=t4.text;
                                String gender=type;
                                String city_name=city;
                                String img=f.path;


                                if(widget.l != null)
                                {
                                  String qry = "UPDATE image_pic set name='$name',contact='$contact',email='$email',password='$password',gender='$gender',city='$city_name',img='$img' where id=${widget.l!['id']}";
                                  device_img.database!.rawUpdate(qry);
                                }
                                else
                                {
                                  int random=Random().nextInt(100);
                                  String imag_name="${random}.png";
                                  File f = File("${device_img.dir!.path}/${imag_name}");
                                  await f.writeAsBytes(await image!.readAsBytes());

                                  String qry = "insert into image_pic values(null,'$name', '$contact', '$email', '$password', '$gender', '$city_name', '$img')";
                                  device_img.database!.rawInsert(qry);
                                }

                                // print(qry);

                                setState(() { });

                              }, child: Text("ADD"))
                          ),
                          Expanded(flex: 1,
                              child: ElevatedButton(onPressed: () async {

                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return img_view();
                                },));

                                setState(() { });

                              }, child: Text("VIEW"))
                          ),
                        ],))
                      ]),
                    ),
                  )
              ),
            ]),
            )
        );
    }
}
