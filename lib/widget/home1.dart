import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/utility/my_style.dart';

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  @override
  void initState() {
    super.initState();
    date();
    date1();
  }

  DateTime timedate = DateTime.now();
  var time = DateFormat.yMMMEd();
  var timee = DateFormat.Hms();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                date(),
                date1(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text date1() {
    return Text(
      "เวลา: ${timee.format(timedate)}",
      style: MyStyle().mainTitle,
    );
  }

  Text date() {
    return Text(
      "วัน: ${time.format(timedate)}",
      style: MyStyle().mainTitle,
    );
  }
}
