import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/data_model.dart';
import 'package:myapp/model/status_model.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/utility/connet.dart';
import 'package:myapp/utility/dialog.dart';
import 'package:myapp/utility/my_style.dart';
import 'package:myapp/widget/edit.dart';
import 'package:myapp/widget/home1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkdarable extends StatefulWidget {
  @override
  _CheckdarableState createState() => _CheckdarableState();
}

class _CheckdarableState extends State<Checkdarable> {
  Widget ed = Checkdarable();
  String qr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('ตรวจนับครุภัณฑ์'),),
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyStyle().showText1('*กรณี QR Code ชำรุด'),
            durableForm(),
            scan()
          ],
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        onPressed: () {
          qrCold();
        },
        label: Text('Scan'),
      ),
    );
  }

  Widget scan() => Container(
        // การเช็คค่าว่าว่างหรือไม่ถ้าไม่ก็ทำงานต่อได้
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            print('เลขครุภัณฑ์ = $qr');
            if (qr == null || qr.isEmpty) {
              normalDialog(context, 'กรุณากรอกเลขครุภัณฑ์ด้วยค่ะ');
            } else {
              scanserve();
            }
          },
          child: Text(
            'ตรวจนับ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> scanserve() async {
    // การเอาค่าขึ้น database
    String url =
        '${Constant().domin}data/getdatadurable1.php?qr=$qr';
    await Dio().get(url).then((value) {
      print('value =======> $value');
      if (value.toString() != 'null') {
        normalDialog(context, 'ครุภัณฑ์นี้ตรวจแล้วค่ะ');
      } else {
        check();
      }
    });
  }

  Widget durableForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => qr = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: MyStyle().darkColor),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'เลขครุภัณฑ์',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            ),
          ),
        ),
      );

  Future<Null> qrCold() async {
    //สแกน qr
    try {
      var result = await BarcodeScanner.scan();
      qr = result.rawContent;
      print('result ======> $qr');
      check2();
    } catch (e) {}
  }

  Future<Null> check() async {
    // เป็นการเอาค่าไปตรวจดูใน database
    String url =
        '${Constant().domin}data/getdatadurable.php?qr=$qr';
    Response response = await Dio().get(url);
    if (response.toString() == 'null') {
      normalDialog(context, 'ไม่มีข้อมูลของครุภัณฑ์นี้');
    }
    var resultt = json.decode(response.data);
    for (var map in resultt) {
      Datadurable datadurable = Datadurable.fromJson(map);
      Userdata userdata = Userdata.fromJson(map);
      Statusdurable statusdurable = Statusdurable.fromJson(map);
      if (qr == datadurable.assetnumber) {
        print('qr ================================== $resultt');
        routetor(Edit(), datadurable, userdata, statusdurable);
      }
    }
  }

// การเรียกใช้ข้อมูลครุภัณฑ์
  Future<Null> check2() async {
    // เป็นการเอาค่าไปเช็คว่าครุภัณฑ์ชิ้นนี้ตรวจแล้วหรือยัง
    String url =
        '${Constant().domin}data/getdatadurable1.php?qr=$qr';
    await Dio().get(url).then((value) {
      print('value =======> $value');
      if (value.toString() != 'null') {
        normalDialog(context, 'ครุภัณฑ์นี้ตรวจแล้วค่ะ');
      } else {
        check();
      }
    });
  }

// เป็นตัวเก็บข้อมูลที่สแกนเข้ามา
  Future<Null> routetor(Widget my, Datadurable datadurable, Userdata userdata,
      Statusdurable statusdurable) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('assetnumber', datadurable.assetnumber);
    preferences.setString('name', datadurable.name);
    preferences.setString('brand', datadurable.brand);
    preferences.setString('model', datadurable.model);
    preferences.setString('machinenumber', datadurable.machinenumber);
    preferences.setString('owner', datadurable.owner);
    preferences.setString('room', datadurable.room);
    preferences.setString('state', datadurable.state);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (value) => my,
    );
    Navigator.push(context, route);
  }
}
