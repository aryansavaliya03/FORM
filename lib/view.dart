import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:form2/main.dart';
//import 'package:form/main.dart';

class view extends StatefulWidget {
  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List l = [];
  bool con = false;

  get() {
    String sql = "select * from form";
    Home1.database!.rawQuery(sql).then((value) async {
      l = value;
      print(l);
      setState(() {});
      var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/form";
      Home1.dir = Directory(path);

      if(! await Home1.dir!.exists())
      {
      Home1.dir!.create();
      }
    });
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("image/form.background.jpg"))),
        child: ListView.builder(
          itemCount: l.length,
          itemBuilder: (context, index) {
            String str123 = "${Home1.dir!.path}/${l[index]['img']}";
            File f = File(str123);
            // print("..............$f");

            return Card(
              child: ListTile(
                tileColor: Colors.deepOrange.shade300,
                title: Text("${l[index]['name']}"),
                subtitle: Wrap(
                  children: [
                    Text("${l[index]['number']}"),
                    Text("${l[index]['Email']}"),
                    Text("${l[index]['password']}"),
                  ],
                ),
                leading: CircleAvatar(
                    backgroundImage: FileImage(f),
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          String str =
                              "delete from form where id=${l[index]['id']}";
                          Home1.database!.rawDelete(str);
                          print(str);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return view();
                            },
                          ));
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return Home1(l[index]);
                            },
                          ));
                        },
                        icon: Icon(Icons.edit)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
