import 'package:flutter/material.dart';
import 'package:myapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Datauser extends StatefulWidget {
  @override
  _DatauserState createState() => _DatauserState();
}

class _DatauserState extends State<Datauser> {
  String nameUser, userName, pass, status;
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
      userName = preferences.getString('User');
      pass = preferences.getString('Pass');
      status = preferences.getString('Status');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, Colors.orange.shade600],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showText('ชื่อ:  $nameUser'),
                MyStyle().showText('ผู้ใช้งาน:  $userName'),
                // MyStyle().showText('รหัส:  $pass'),
                MyStyle().showText('สถานะ:  $status'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
