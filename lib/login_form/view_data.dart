import 'dart:io';

// import 'package:data_base/offline(sqflitte)_image_data.dart';
import 'package:database_demo/login_form/first_details.dart';
// import 'package:demo/login_form/first_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,home: img_view(),
  ));
}
class img_view extends StatefulWidget {
  const img_view({super.key});

  @override
  State<img_view> createState() => _img_viewState();
}

class _img_viewState extends State<img_view> {

  List<Map> l = [];

  get_data()
  async {
    String qry = "select * from image_pic";
    l = await device_img.database!.rawQuery(qry);
    print(l);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green.shade300,
              title: Text("VIEW DETAILS",style: TextStyle(fontSize: 25,color: Colors.pink.shade300)),
              centerTitle: true,
            ),

            body: FutureBuilder(future: get_data(), builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.done)
              {
                return ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: 100,width: 50,
                          color: Colors.grey,
                          child: Image.file(fit: BoxFit.fill,File(l[index]['img'])),
                        ),
                        title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          Text(l[index]['name']),Text(l[index]['contact'])
                        ]),
                        subtitle: Column(children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                            Text(l[index]['password']),Text(l[index]['email']),
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                            Text(l[index]['gender']),Text(l[index]['city']),
                          ],),
                        ]),
                        trailing: Wrap(children: [
                          IconButton(onPressed: (){
                            String qry = "delete from image_pic where id=${l[index]['id']}";
                            device_img.database!.rawDelete(qry);
                            setState(() { });
                          }, icon: Icon(Icons.delete)),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return device_img(l[index]);
                            },));
                            setState(() { });
                          }, icon: Icon(Icons.edit))
                        ]),
                      ),
                    );
                  },
                );
              }
              else
              {
                return CircularProgressIndicator();
              }
            },),
            )
        );
    }
}
