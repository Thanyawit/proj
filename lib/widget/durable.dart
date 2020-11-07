import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/data_model.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/utility/connet.dart';
import 'package:myapp/utility/dialog.dart';
import 'package:myapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Durable extends StatefulWidget {
  @override
  _DurableState createState() => _DurableState();
}

class _DurableState extends State<Durable> {
  Datadurable datadurable;
  List<Datadurable> datadurables =
      List(); //ทำการสร้าง List เพื่อเก็บข้อมูลของ Datadurable

  @override // เป็น Method แรกที่จะถูกเรียกหลังจาก constructor
  void initState() {
    super.initState();
    showdata();
  }

  Future<Null> showdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String namee = preferences.getString('Name');
    print('===========================$namee');

    String url =
        '${Constant().domin}data/getAllData.php?name=$namee';
     Dio().get(url).then((value) {
      var result =
          json.decode(value.data); // เป็นการแปลงค่าจาก database เป็นค่าปกติ
      print(result);
      for (var map in result) {
        datadurable =
            Datadurable.fromJson(map); // เป็นการส่งข้อมูลเข้า datadurable
        setState(() {
          // ถ้าได้ข้อมูลมาที่หลังค่อยทำใหม่ใหม่
          datadurables.add(datadurable);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ถ้า datadurable มีค่าเท่ากับ 0 ให้ทำหลังเครื่องหมาย ? แต่ถ้าไม่เท่ากับให้ทำ หลัง :
    return datadurables.length == 0
        ? MyStyle().showProgress()
        : ListView.builder(
            itemCount: datadurables.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    print('you click = $index');
                    durableshow(index); // เมื่อ check แล้วจะส่งค่าไปยัง method
                  },
                  child: Row(
                    // จะทำการวนลูป List หรือ อาเรย์ของ context
                    children: <Widget>[
                      showdurable(context, index),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'เลขครุภัณฑ์  ' +
                                      datadurables[index].assetnumber,
                                  style: MyStyle().mainTitle,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'ชื่อครุภัณฑ์ ' + datadurables[index].name,
                                  style: MyStyle().mainTitle,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                            0.5 -
                                        8.0,
                                    child: Text(
                                      'ห้อง ' + datadurables[index].room,
                                      style: MyStyle().mainTitle,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
  }

  Container showdurable(BuildContext context, int index) {
    // เป็นการดูความกว้างความสูงของมือถือแล้วจะกำหนดตามนั้นเลย
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(
              '${Constant().domin}${datadurables[index].urlPicture}'),
        ),
      ),
    );
  }

  // สร้าง method
  Future<Null> durableshow(int index) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('เลขครุภัณฑ์ ${datadurables[index].assetnumber}' ,
              style: MyStyle().mainTitle,
            ),
          ],
        ),
        children: <Widget>[
          Container(
            width: 200,
            height: 180,
            child: Image.network(
                '${Constant().domin}${datadurables[index].urlPicture}'),
          )
        ],
      ),
    );
  }
}
