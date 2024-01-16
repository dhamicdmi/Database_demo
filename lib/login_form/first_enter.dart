import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
// import 'package:getwidget/components/radio/gf_radio.dart';


void main() {
  runApp(MaterialApp(
    home: first_enter(),
  ));
}

class first_enter extends StatefulWidget {
  const first_enter({super.key});

  @override
  State<first_enter> createState() => _first_enterState();
}

class _first_enterState extends State<first_enter> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  bool pass = true;
  String gender = "";
  int city = 0;

  OutlineInputBorder myinputborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blue.shade200, width: 3));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blueAccent.shade100, width: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text("FIRST PAGE",
              style: TextStyle(
                  color: Colors.black45, fontSize: 30, letterSpacing: 5)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                // color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage("img/app.jpg"), fit: BoxFit.cover)),
          )),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/back.jpg"), fit: BoxFit.fill)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
              image: DecorationImage(
                  image: AssetImage("img/back.jpg"), fit: BoxFit.fill)),
          child: Column(
            children: [
              Text(""),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    // hintText: "Enter Name",
                    labelText: "Enter Name",
                    labelStyle: TextStyle(color: Colors.black45),
                    border: myinputborder(),
                    enabledBorder: myinputborder(),
                    focusedBorder: myfocusborder()),
                controller: t1,
              ),
              Text(""),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.call),
                    labelText: "Enter Contact",
                    labelStyle: TextStyle(color: Colors.black45),
                    border: myinputborder(),
                    enabledBorder: myinputborder(),
                    focusedBorder: myfocusborder()),
                controller: t2,
              ),
              Text(""),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: "Enter gmail",
                    labelStyle: TextStyle(color: Colors.black45),
                    border: myinputborder(),
                    enabledBorder: myinputborder(),
                    focusedBorder: myfocusborder()),
                controller: t3,
              ),
              Text(""),
              TextField(
                obscureText: pass,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Enter password",
                    suffix: IconButton(
                      onPressed: () {
                        if (pass) {
                          pass = false;
                        } else {
                          pass = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(
                          pass == true ? Icons.remove_red_eye : Icons.password),
                    ),
                    labelStyle: TextStyle(color: Colors.black45),
                    border: myinputborder(),
                    enabledBorder: myinputborder(),
                    focusedBorder: myfocusborder()),
                controller: t4,
              ),
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "GENDER:",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text("MALE"),
                  GFRadio(
                    activeBgColor: Colors.black45,
                    // activeBorderColor: Colors.white,
                    radioColor: Colors.red,
                    inactiveBgColor: Colors.white10,
                    // inactiveBorderColor: Colors.transparent,
                    autofocus: false,

                    // type: Icon(Icons.account_circle),
                    inactiveIcon: Icon(Icons.male),

                    value: "male",
                    groupValue: gender,
                    onChanged: (value) {
                      gender = value!;
                      setState(() {});
                    },
                  ),
                  Text("FEMALE"),
                  GFRadio(
                    activeBgColor: Colors.black45,
                    inactiveIcon: Icon(Icons.female),
                    inactiveBgColor: Colors.white10,
                    value: "female",
                    groupValue: gender,
                    onChanged: (value) {
                      gender = value!;
                      setState(() {});
                    },
                  ),

                  // Expanded(flex: 3,
                  //   child: Container(
                  //     child: Row(
                  //       children: [
                  //         Text("MALE"),
                  //         // Icon(Icons.male),
                  //         Radio(value: "male", groupValue: gender, onChanged: (value) {
                  //           gender=value!;
                  //           setState(() {
                  //
                  //           });
                  //         },),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Expanded(flex: 3,
                  //   child: Container(
                  //     child: Row(
                  //       children: [
                  //         Text("FEMALE"),
                  //         // Icon(Icons.female),
                  //         Radio(value: "female", groupValue: gender, onChanged: (value) {
                  //           gender=value!;
                  //           setState(() {
                  //
                  //           });
                  //         },),
                  //       ],
                  //     ),
                  //
                  //   ),
                  // ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("CITY:",style: TextStyle(fontSize: 15),),
                  DropdownButton(
                    value: city,
                    items: [
                      DropdownMenuItem(
                        child: Text("Select city"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("surat"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("vadodra"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("rajkot"),
                        value: 3,
                      ),DropdownMenuItem(
                        child: Text("junagadh"),
                        value: 4,
                      ),DropdownMenuItem(
                        child: Text("amreli"),
                        value: 5,
                      ),DropdownMenuItem(
                        child: Text("ahemdabad"),
                        value: 6,
                      ),
                      DropdownMenuItem(
                        child: Text("bhavnagar"),
                        value: 7,
                      ),
                    ],
                    onChanged: (value) {
                      city=value!;
                      setState(() {});
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
