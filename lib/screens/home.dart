import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/data_model.dart';
import 'package:myapp/model/datatime_model.dart';
import 'package:myapp/utility/connet.dart';
import 'package:myapp/utility/dialog.dart';
import 'package:myapp/utility/my_style.dart';
import 'package:myapp/widget/checkdurable.dart';
import 'package:myapp/widget/durable.dart';
import 'package:myapp/screens/login.dart';
import 'package:myapp/widget/datauser.dart';
import 'package:myapp/widget/home1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget durablee = Home1(); // ให้ทำการเข้ามาแล้วใช้หน้า Home1 เป็นหน้าขึ้น
  DateTime timedate = DateTime.now(); // การใช้เวลาของเครื่องนะเวลานี้
  String nameUser, userName, iduser, i,ti,date;

  @override//คือทำหน้าที่เข้ามาหน้านี้แล้วให้ทำฟังก์ชันของ findUser() ก่อน
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {/// เป็นการเรียกค่ามาใช้หน้านี้
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      iduser = preferences.getString('id_user');
      nameUser = preferences.getString('Name');
      userName = preferences.getString('User');
    });
  }

  Future<Null> signOut() async {// คือการเคลียค่าของที่เก็บไว้
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // exit(0);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (value) => Login(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าหลัก'),
      ),
      drawer: showDrawer(),
      body: durablee,
    );
  }

  Drawer showDrawer() => Drawer(//เป็นการทำหน้า
        child: ListView(
          children: <Widget>[
            showuser(),
            home1(),
            user(),
            durable(),
            durebleevent(),
            out(),
          ],
        ),
      );

  ListTile durebleevent() {//ทำการไปเรียกใช้หน้าของ Durable
    return ListTile(
      leading: Icon(Icons.event_note),
      title: Text('ครุภัณฑ์ที่รับผิดชอบ'),
      onTap: () {
        setState(() {
          durablee = Durable();
        });
        Navigator.pop(context);
      },
    );
  }
    ListTile home1() {
    return ListTile(
        leading: Icon(Icons.home),
        title: Text('หน้าแรก'),
        onTap: () {
          setState(() {
          durablee = Home1();
        });
        Navigator.pop(context);
          
        });
  }

  ListTile durable() {
    return ListTile(
        leading: Icon(Icons.event_available),
        title: Text('ตรวจนับครุภัณฑ์'),
        onTap: () {
          datadate();
        });
  }

  Future<Null> datadate() async {// เป็นการเช็คค่าของเวลาว่ามีเวลาในช่วงที่กำหนดไหมถ้ามีสามารถเข้าไปทำหน้าต่อไปได้แต่ถ้าไม่มีจะให้แสดงค่าว่า ไม่อยู่ในช่วงเวลาที่กำหนด
    // var formatter = DateFormat('y-MM-dd hh:mm:ss');
    // ti = formatter.format(timedate);

    String url = '${Constant().domin}data/gettime.php';
    try {
      await Dio().get(url).then((value) {
        if (value.toString() == 'null') {
          normalDialog(context, 'ไม่อยู่ในช่วงเวลาที่กำหนดไว้');
        } else {
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => Checkdarable(),
          );
          Navigator.push(context,route);
        }
      });
    } catch (e) {}
  }

  ListTile user() {
    return ListTile(
        leading: Icon(Icons.people),
        title: Text('ข้อมูลส่วนตัว'),
        onTap: () {
          setState(() {
            durablee = Datauser();
          });
          Navigator.pop(context);
        });
  }

  ListTile out() {// ทำการไปเรียกใช้ฟังก์ชัน
    return ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Logout'),
        onTap: () => signOut());
  }

  UserAccountsDrawerHeader showuser() {//เป็นการเรียกค่ามาดูข้อมูล
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/4.jpg'), fit: BoxFit.cover),
        ),
        accountName: Text('Name: ' + nameUser, style: MyStyle().mainTitle1,),
        accountEmail: Text('User: ' + userName, style: MyStyle().mainTitle1,));
  }
}
