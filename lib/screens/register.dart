import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/login.dart';
import 'package:myapp/utility/connet.dart';
import 'package:myapp/utility/dialog.dart';
import 'package:myapp/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username, password, name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showlogo(),
                MyStyle().mySizebox(),
                MyStyle().showText('ลงทะเบียนเข้าสู่ระบบครุภัณฑ์'),
                MyStyle().showText(''),
                userForm(),
                MyStyle().mySizebox(),
                passForm(),
                MyStyle().mySizebox(),
                nameFrom(),
                MyStyle().mySizebox(),
                register(),
                back(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget register() => Container(
      width: 100.0,
      child: RaisedButton(
        color: Colors.green,
        onPressed: () {
          if (username == null ||
              username.isEmpty ||
              password == null ||
              password.isEmpty ||
              name == null ||
              name.isEmpty) {
            normalDialog(context, 'กรุณากรอกข้อมูล');
          } else {
            scanserve();
          }
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ));

  Future<Null> scanserve() async {
    // การเอาค่าขึ้น database
    String url = '${Constant().domin}data/getdatauser.php?username=$username';
    await Dio().get(url).then((value) {
      print('value =======> $value');
      if (value.toString() != 'null') {
        normalDialog(context, 'username มีคนใช้แล้วค่ะ');
      } else {
        regis();
      }
    });
  }

  Future<Null> regis() async {
    //ทำการเอาข้อมูลที่กรอกเข้าไปเซคใน database
    String url =
        '${Constant().domin}data/addData.php?isAdd=true&username=$username&password=$password&Name=$name';
    try {
      Response response = await Dio().get(url);
      print(response);
      MaterialPageRoute route = MaterialPageRoute(builder: (value) => Login());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } catch (e) {}
  }

  Widget back() => Container(
      width: 100.0,
      child: RaisedButton(
        color: Colors.red,
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Login(),
          );
          Navigator.push(context, route);
        },
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.white),
        ),
      ));

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.black,
              ),
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Username',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );

  Widget nameFrom() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'name',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );

  Widget passForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.black),
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );
}
