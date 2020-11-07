import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.orange.shade900;
  Color blueColor = Colors.blue.shade500;
  Color tealColor = Colors.teal.shade500;

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(string,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );

  TextStyle mainTitle1 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  Text showText(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showText1(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.red.shade900,
          fontWeight: FontWeight.bold,
        ),
      );
  Text showText3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );
      Text showText4(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );
  Container showlogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/1.png'),
    );
  }

  Container showlogo2() {
    return Container(
      width: 120.0,
      child: Image.asset('images/2.png'),
    );
  }
}
