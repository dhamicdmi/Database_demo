import 'package:database_demo/view_contact.dart';
// import 'package:database_sqlfli/view_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}class first extends StatefulWidget {
  static Database? database;
  Map? m;
  first([this.m]);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();

  Widget txt_fun(String str,TextEditingController t){
    return TextField(
      controller: t,
      decoration: InputDecoration(hintText: str,border: OutlineInputBorder()),
    );

  }
  get_db() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    first.database= await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE contact_book (id INTEGER PRIMARY KEY, name TEXT, contact TEXT, city TEXT)');
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_db();
    if(widget.m!=null)
    {
      t1.text=widget.m!['name'];
      t2.text=widget.m!['contact'];
      t3.text=widget.m!['city'];
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Contact"),
        ),
        body: Column(
            children: [
              txt_fun("Enter name", t1),
              txt_fun("Enter Contact", t2),
              txt_fun("Enter City", t3),
              ElevatedButton(onPressed: () {
                String name=t1.text;
                String contact=t2.text;
                String city=t3.text;
                if(widget.m!=null)
                {
                  String qry="update contact_book set name='$name',contact='$contact',city='$city'where id=${widget.m!['id']}";
                  first.database!.rawUpdate(qry);
                }else
                {
                  String qry="insert into contact_book values(null,'$name','$contact','$city')";
                  first.database!.rawInsert(qry);
                }
                Navigator.push(context,MaterialPageRoute(builder: (context) {
                  return view_contact();
                },));

              }, child: Text("submit")),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return view_contact();
                },));
              }, child: Text("View")),
            ],
            ),
        );
    }
}
