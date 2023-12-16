import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

//import 'package:form/view.dart';
import 'package:form2/view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: Home1(),
    theme:
        ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.deepOrange)),
  ));
}

class Home1 extends StatefulWidget {
  static Database? database;
  static Directory? dir;
  Map? l;
  Home1([this.l]);
  @override
  State<Home1> createState() => _Home1State();
}
class _Home1State extends State<Home1> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();
  String gender = "male";
  dynamic s = "surat";
  bool t = false;
  bool error_name = false;
  bool error_number = false;
  bool error_Email = false;
  bool error_pass = false;
  bool error_image = false;
  ImagePicker picker = ImagePicker();
  XFile? image;
  XFile? photo;
  List<DropdownMenuItem> sity = [
    DropdownMenuItem(
      child: Text("surat"),
      value: "surat",
    ),
    DropdownMenuItem(
      child: Text("ahemdavad"),
      value: "ahemdavad",
    ),
    DropdownMenuItem(
      child: Text("vadodra"),
      value: "vadodra",
    ),
    DropdownMenuItem(
      child: Text("junagadh"),
      value: "junagadh",
    ),
    DropdownMenuItem(
      child: Text("jetpur"),
      value: "jetpur",
    ),
    DropdownMenuItem(
      child: Text("bhavnagr"),
      value: "bhavngar",
    ),
    DropdownMenuItem(
      child: Text("kach"),
      value: "kach",
    ),
  ];

  get() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
    var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS) +
        "/form";
    Home1.dir = Directory(path);

    if (!await Home1.dir!.exists()) {
      Home1.dir!.create();
    }
  }

  get1() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// open the database
    Home1.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE form (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, number TEXT, Email TEXT, password TEXT, gender TEXT, s TEXT, img TEXT)');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    get1();
    if (widget.l != null) {
      name.text = widget.l!['name'];
      number.text = widget.l!['number'];
      Email.text = widget.l!['Email'];
      password.text = widget.l!['password'];
      gender = widget.l!['gender'];
      s = widget.l!['s']!;

      String new_path = "${Home1.dir!.path}/${widget.l!['img']}";
      File file = File(new_path);
      image = XFile(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("FORM")),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("image/form.background.jpg"))),
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                width: 2,
              )),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                    )),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      errorText: (error_name) ? "Enter Text" : null,
                      hintText: "\t\tName"),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                    )),
                child: TextField(
                  controller: number,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "\t\tNumber",
                    errorText: (error_number) ? "Enter Valid Number" : null,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                    )),
                child: TextField(
                  controller: Email,
                  decoration: InputDecoration(
                    hintText: "\t\tEmail",
                    errorText: (error_Email) ? "Enter Valid Email" : null,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                    )),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: "\t\tpassword",
                    errorText: (error_pass) ? "Enter valid password" : null,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Radio(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (value) async {
                      gender = value!;
                      setState(() {});
                    },
                  ),
                  Text("Male", style: TextStyle(fontSize: 20)),
                  Radio(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (value) {
                      gender = value!;
                      setState(() {});
                    },
                  ),
                  Text("Female", style: TextStyle(fontSize: 20)),
                ],
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                    )),
                child: Row(
                  children: [
                    Text("\t\t Select your sity  -->  ",
                        style: TextStyle(fontSize: 20)),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: DropdownButton(
                        value: s,
                        items: sity,
                        onChanged: (value) {
                          s = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //Expanded(child: Text("")),
              Expanded(
                child: Container(
                  child: (image!=null) ? Image.file(File(image!.path)):Text("Enter image",style: TextStyle(fontSize: 30)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.deepOrange.shade300,
                              title: Text('Choose image'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      image = await picker.pickImage(
                                          source: ImageSource.camera);
                                      t = true;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text('Camera')),
                                TextButton(
                                    onPressed: () async {
                                      image = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      t = true;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text('Gallery'))
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "ENTER IMAGE",
                        style: TextStyle(fontSize: 15),
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        String Name = name.text;
                        String Number = number.text;
                        String email = Email.text;
                        String Password = password.text;
                        String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = new RegExp(patttern);
                        if (Name == "") {
                          error_name = true;
                        }
                        if (Number == "" || !regExp.hasMatch(Number)) {
                          error_number = true;
                        } else {
                          error_number = false;
                        }
                        if (email.trim() == "" ||
                            EmailValidator.validate(Email.text.trim())) {
                          error_Email = false;
                        } else {
                          error_Email = true;
                        }
                        if (Password == "") {
                          error_pass = true;
                        }
                        if (image == null)error_image = true;
                        setState(() {});
                        if (!error_name &&
                            !error_number &&
                            !error_Email &&
                            !error_pass) {
                          int random = Random().nextInt(100);
                          String? imag_name = "${random}.png";
                          File f = File("${Home1.dir!.path}/${imag_name}");
                          f.writeAsBytes(await image!.readAsBytes());
                          if (widget.l != null) {
                            if (image != null) {
                              File file =
                                  File("${Home1.dir!.path}/${imag_name}");
                              file.delete();
                              imag_name = "${Random().nextInt(100)}.jpg";
                              File f = File("${Home1.dir!.path}/${imag_name}");
                              f.writeAsBytes(await image!.readAsBytes());
                            }
                            String str =
                                "update form set name='$Name',number='$Number',Email='$email',password='$Password',gender='$gender',s='$s',img='$imag_name' where id=${widget.l!['id']}";
                            Home1.database!.rawUpdate(str);
                            print(str);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return Home1();
                              },
                            ));
                            setState(() {});
                          } else {
                            if (name.text != "" &&
                                number.text != "" &&
                                Email.text != "" &&
                                password.text != "") {
                              String sql =
                                      "insert into form values(null,'$Name','$Number','$email','$Password','$gender','$s','$imag_name')";
                              Home1.database!.rawInsert(sql);
                              print(sql);
                            }
                          }
                          name.text = "";
                          number.text = "";
                          Email.text = "";
                          password.text = "";
                          gender = "";
                          s = "surat";
                          image = null;
                        }

                        setState(() {});
                      },
                      child: Text("submit")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return view();
                          },
                        ));
                      },
                      child: Text("view"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
