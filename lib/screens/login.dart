import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/homeuser.dart';
import 'package:myapp/screens/register.dart';
import 'package:myapp/utility/connet.dart';
import 'package:myapp/utility/dialog.dart';
import 'package:myapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username, password;

  @override
  Widget build(BuildContext context) {
    //เป็นการจัดหน้าและตกแต่ง
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //เป็นการจัดหน้า
                MyStyle().showlogo(),
                MyStyle().mySizebox(),
                MyStyle().showText('ครุภัณฑ์'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passForm(),
                MyStyle().mySizebox(),
                login(), MyStyle().mySizebox(), register()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget login() => Container(
        // เป็รการเช็คค่าว่างในช่องกรอก
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            print('user = $username pass = $password');
            if (username == null ||
                username.isEmpty ||
                password == null ||
                password.isEmpty) {
              print('กรุณากรอกข้อมูล');
              normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
            } else {
              loginserve();
            }
          },
          child: Text(
            'Singin',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget register() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Colors.red,
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => Register());
            Navigator.push(context, route);
          },
          child: Text('Singup'),
        ),
      );

  Future<Null> loginserve() async {
    //ทำการเอาข้อมูลที่กรอกเข้าไปเซคใน database
    String url =
        '${Constant().domin}data/getUserWhereUserMaster.php?isAdd=true&username=$username';
    try {
      Response response = await Dio().get(url);
      print(response);
      if (response.toString() == 'null') {
        normalDialog(context, 'รหัสไม่ถูกต้อง');
      }
      var result = json.decode(response.data);
      print(result);
      for (var map in result) {
        Userdata userdata = Userdata.fromJson(map);
        if (password == userdata.password) {
          if (userdata.status == 'user') {
            routetor1(Homeuser(), userdata);//เป็นการเรียกใช้ฟังก์ชัน routertor
          }else {
            routetor(Home(), userdata);//เป็นการเรียกใช้ฟังก์ชัน routertor
          }
        } else {
          normalDialog(context, 'รหัสไม่ถูกต้อง');
        }
      }
    } catch (e) {}
  }

  Future<Null> routetor1(Widget my, Userdata userdata) async {
    // ทำการเซ็ตค่าให้ไปอยู่ใน user_model.dart
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id_user', userdata.idUser);
    preferences.setString('Name', userdata.name);
    preferences.setString('User', userdata.username);
    preferences.setString('Pass', userdata.password);
    preferences.setString('Status', userdata.status);

    MaterialPageRoute route = MaterialPageRoute(
      // ทำการเปลี่ยนหน้าไปยังหน้า Home
      builder: (context) => my,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }


  Future<Null> routetor(Widget my, Userdata userdata) async {
    // ทำการเซ็ตค่าให้ไปอยู่ใน user_model.dart
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id_user', userdata.idUser);
    preferences.setString('Name', userdata.name);
    preferences.setString('User', userdata.username);
    preferences.setString('Pass', userdata.password);
    preferences.setString('Status', userdata.status);

    MaterialPageRoute route = MaterialPageRoute(
      // ทำการเปลี่ยนหน้าไปยังหน้า Home
      builder: (context) => my,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        // รับค่าจากแป้นพิมพ์
        width: 250.0,
        child: TextField(
          onChanged: (value) => username =
              value.trim(), // เป็นการเอาค่าจากแป้นพิมพ์มาเก็บไว้ที่ username
          decoration: InputDecoration(
            //เป็นการตกแต่ง
            prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Username',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            ),
          ),
        ),
      );

  Widget passForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: MyStyle().darkColor),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
