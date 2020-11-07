import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/data_model.dart';
import 'package:myapp/model/position_model.dart';
import 'package:myapp/utility/connet.dart';
import 'package:myapp/utility/dialog.dart';
import 'package:myapp/utility/my_style.dart';
import 'package:myapp/widget/checkdurable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  DateTime timedate = DateTime.now();
  String durableCodeno,
      durableName,
      durableBrand,
      durableMachinenumber,
      name,
      status,
      namee,
      statusid,
      position,
      urlimage,
      urlimage2,
      userid;
  File file, file1;

  @override
  void initState() {
    super.initState();
    finddurable();
    positionnn();
  }

  Future<Null> finddurable() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      durableCodeno = preferences.getString('assetnumber');
      durableName = preferences.getString('name');
      durableBrand = preferences.getString('brand');
      durableMachinenumber = preferences.getString('machinenumber');
      statusid = preferences.getString('statusid');
      namee = preferences.getString('owner');
      status = preferences.getString('state');
      position = preferences.getString('room');
      userid = preferences.getString('Name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขครุภัณฑ์'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // date(),
              MyStyle().showText(''),
              MyStyle().showText3('   1. เลขครุภัณฑ์: $durableCodeno'),
              MyStyle().showText3('   2. ชื่อครุภัณฑ์:  $durableName'),
              MyStyle().showText3('   3. ยี่ห้อครุภัณฑ์:  $durableBrand'),
              MyStyle()
                  .showText3('   4. เลขยี่ห้อครุภัณฑ์:  $durableMachinenumber'),
              MyStyle().showText3('   5. ชื่อผู้รับผิดชอบ: $namee'),
              MyStyle().showText3('   6. สถานะ: $status'),
              MyStyle().showText3('   7. ตำแหน่งครุภัณฑ์: $position'),
              MyStyle().mySizebox(),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      MyStyle().showText1('* แก้ไขครุภัณฑ์'),
                      MyStyle().showText3('สถานะครุภัณฑ์ปัจจุบัน'),
                      statusedit(),
                      statusedit1(),
                      MyStyle().showText3('ตำแหน่งปัจจุบัน'),
                      positiondropdown(),
                      MyStyle().showText3('รูปภาพครุภัณฑ์ปัจจุบัน'),
                      show1(),
                      show2(),
                      editt()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropDownField positiondropdown() {
    return DropDownField(
      controller: citi,
      hintText: "Select Position",
      enabled: true,
      itemsVisibleInDropdown: 3,
      items: cities,
      onValueChanged: (value) {
        setState(() {
          selectposition = value;
          position = value;
          print(position);
        });
      },
    );
  }

  Positiondrop positiondrop;
  String selectposition = "";
  final citi = TextEditingController();
  List<String> cities = List();

  Future<Null> positionnn() async {
    String url = '${Constant().domin}data/getdrop.php';
    await Dio().get(url).then((value) {
      var c = json.decode(value.data);
      print(c);
      for (var map in c) {
        positiondrop = Positiondrop.fromJson(map);
        cities.add(positiondrop.room);
        print(cities);
      }
      print(positiondrop.room);
    });
  }

  var formatter = DateFormat('y-MM-dd hh:mm:ss');

  ListTile date() {
    return ListTile(
      title: Text("${formatter.format(timedate)}"),
    );
  }

//เป็นการเรียกใช้กล้องและแกลอรี่ในโทรศัพท์
  Widget show1() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () => choseImage(ImageSource.camera)),
                Container(
                  width: 150.0,
                  height: 150.0,
                  child: file == null
                      ? Image.asset('images/1.png')
                      : Image.file(file),
                ),
                IconButton(
                  icon: Icon(Icons.add_photo_alternate),
                  onPressed: () => choseImage(ImageSource.gallery),
                ),
              ],
            ),
          ),
        ],
      );

  Widget show2() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () => choseImage2(ImageSource.camera)),
                Container(
                  width: 150.0,
                  height: 150.0,
                  child: file1 == null
                      ? Image.asset('images/1.png')
                      : Image.file(file1),
                ),
                IconButton(
                  icon: Icon(Icons.add_photo_alternate),
                  onPressed: () => choseImage2(ImageSource.gallery),
                ),
              ],
            ),
          ),
        ],
      );

  Future<Null> choseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
          source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Future<Null> choseImage2(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
          source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file1 = object;
      });
    } catch (e) {}
  }

  Widget statusedit() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              // เป็นการทำตัว
              children: <Widget>[
                Radio(
                  value: 'ใช้งาน',
                  groupValue: statusid,
                  onChanged: (value) {
                    setState(() {
                      statusid = value;
                    });
                  },
                ),
                Text(
                  'ใช้งาน',
                  style: TextStyle(color: MyStyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );
  Widget statusedit1() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'ชำรุด',
                  groupValue: statusid,
                  onChanged: (value) {
                    setState(() {
                      statusid = value;
                    });
                  },
                ),
                Text(
                  'ชำรุด',
                  style: TextStyle(color: MyStyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );
  // Widget positionn() => Container(
  //       // เป็นการเก็บค่าจากแป้นพิมพ์
  //       width: 250.0,
  //       child: TextField(
  //         onChanged: (value) => position = value.trim(),
  //         decoration: InputDecoration(
  //           labelStyle: TextStyle(color: MyStyle().darkColor),
  //           labelText: 'ตำแหน่งปัจจุบัน',
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: MyStyle().darkColor),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: MyStyle().primaryColor),
  //           ),
  //         ),
  //       ),
  //     );
  Widget editt() => Container(
        width: 250.0,
        child: RaisedButton(
          // เป็นการเช็คค่ารูปว่ามีหรือไม่
          color: MyStyle().darkColor,
          onPressed: () {
            print('status = $statusid position = $position');
            if (file == null) {
              normalDialog(context, 'กรุณาเพิ่มรูปภาพด้วยคะ');
            } else if (statusid == null) {
              normalDialog(context, 'กรุณาติ๊กสถานะด้วยคะ');
            } else {
              uploadimage();
            }
          },
          child: Text(
            'บันทึก',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> uploadimage() async {
    // เป็นการอัพโหลดไฟล์ขึ้นในคอม
    int i = 1;
    Random random = Random();
    int a = random.nextInt(100000);
    String nameimage = '$a($i).jpg';
    String url = '${Constant().domin}data/saveFile.php';
    try {
      Map<String, dynamic> map = Map(); // ประกาศค่า map
      map['file'] = await MultipartFile.fromFile(file.path,
          filename: nameimage); // ทำการเข้าค่านี้ไปเข้าไฟล์ saveFile.php

      FormData formData = FormData.fromMap(map); //เตรียมค่าเพื่อโยนขึ้นไป
      await Dio().post(url, data: formData).then((value) {
        //ถ้ามันทำงานสำเร็จจะอยู่หลัง .then
        print('Response ==>>> $value');
        urlimage = '${Constant().domin}data/durablef/$nameimage';
        print('urlimage = $urlimage');
        uploadimage1();
        editserve();
      });
    } catch (e) {}
  }

  Future<Null> uploadimage1() async {
    // เป็นการอัพโหลดไฟล์ขึ้นในคอม
    int i = 2;
    Random random = Random();
    int a = random.nextInt(100000);
    String nameimage2 = '$a($i).jpg';
    String url = '${Constant().domin}data/saveFile.php';
    try {
      Map<String, dynamic> map = Map(); // ประกาศค่า map
      map['file'] = await MultipartFile.fromFile(file1.path,
          filename: nameimage2); // ทำการเข้าค่านี้ไปเข้าไฟล์ saveFile.php

      FormData formData = FormData.fromMap(map); //เตรียมค่าเพื่อโยนขึ้นไป
      await Dio().post(url, data: formData).then((value) {
        //ถ้ามันทำงานสำเร็จจะอยู่หลัง .then
        print('Response ==>>> $value');
        urlimage2 = '${Constant().domin}data/durablef/$nameimage2';
        print('urlimage = $urlimage2');
      });
    } catch (e) {}
  }

  // Future<Null> confirm() async {
  //   // เป็นการถามอีกครั้งว่าแน่ใจว่าจะแก้ไขหรือไม่หรือไม่
  //   showDialog(
  //     context: context,
  //     builder: (context) => SimpleDialog(
  //       title: Text('คุณแน่ใจว่าจะแก้ไขข้อมูล'),
  //       children: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             OutlineButton(
  //               onPressed: () {
  //                 uploadimage();
  //               },
  //               child: Text('แน่ใจ'),
  //             ),
  //             OutlineButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text('ไม่แน่ใจ'),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<Null> editserve() async {
    // เป็นการแก้ไขข้อมูลของครุภัณฑ์และห้องของครุภัณฑ์ที่อยู่
    String url =
        '${Constant().domin}data/editDataWhereId.php?isAdd=true&assetnumber=$durableCodeno&state=$statusid&room=$position&urlPicture=$urlimage';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        editserve1();
      } else {
        normalDialog(context, 'ไม่สามารถอัพข้อมูลได้');
      }
    });
  }

  Future<Null> editserve1() async {
    // อัฟเดทเข้าอีกตารางเพื่อทำการเอาไว้เช็คว่าครุภัณฑ์นี้ทำการตรวจนับแล้ว
    String url =
        '${Constant().domin}data/editDataWhereId1.php?isAdd=true&assetnumber=$durableCodeno&owner=$userid&date=${formatter.format(timedate)}&urlPicture=$urlimage&urlPicture1=$urlimage2';
    await Dio().get(url).then((value) {
      print('=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$value');
      if (value.toString() == 'true') {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => Checkdarable(),
        );
        Navigator.push(context, route);
      } else {
        normalDialog(context, 'ไม่สามารถอัพข้อมูลได้');
      }
    });
  }
}
