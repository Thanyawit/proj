import 'package:flutter/material.dart';
import 'package:myapp/screens/login.dart';
import 'package:myapp/utility/my_style.dart';
import 'package:myapp/widget/datauser.dart';
import 'package:myapp/widget/durable.dart';
import 'package:myapp/widget/home1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homeuser extends StatefulWidget {
  @override
  _HomeuserState createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  Widget durablee = Home1();
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
  Future<Null> signOut() async {// คือการเคลียค่าของที่เก็บไว้
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // exit(0);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (value) => Login(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}