import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table1/Tab1/boiled1_tab.dart';
import 'package:food_app/Table_screen/Table1/Tab1/drink1_tab.dart';
import 'package:food_app/Table_screen/Table1/Tab1/yum1_tab.dart';
import 'package:food_app/Table_screen/Table1/Tab1/puff1_tab.dart';
import 'package:food_app/Table_screen/Table1/Table1_price_scren.dart';
import '../../screen_main_page/add_food.dart';
import '../../tool/my_teb.dart';

class TaBle1 extends StatefulWidget {
  const TaBle1({
    super.key,
  });

  @override
  State<TaBle1> createState() => _TaBle1State();
}

class _TaBle1State extends State<TaBle1> {
  // สร้าง List ของ Tabs ที่จะแสดงประเภทของอาหาร
  List<Widget> myTabs = [
    // ผัด/ทอด
    const MyTeb(
      iconPath: 'images/icon/ผัด.png',
      tebname: ('ผัด/ทอด'),
    ),

    // ต้ม
    const MyTeb(
      iconPath: 'images/icon/ต้ม.png',
      tebname: ('ต้ม'),
    ),
    // ยำ
    const MyTeb(
      iconPath: 'images/icon/ยำ.png',
      tebname: ('ยำ'),
    ),
    // เครื่องดื่ม
    const MyTeb(
      iconPath: 'images/icon/soft_drink.png',
      tebname: ('เครื่องดื่ม'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'โต๊ะ 1',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            // ไม่ให้เป็นสีด้านบน AppBar
            elevation: 0,
            leading: Padding(
              // กำหนดระยะหว่างจากขอบของ Icon
              padding: EdgeInsets.only(left: 10),
              // ปุ่ม Icon ที่กดได้
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey[800],
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Container(
                      width: 50,
                      child: Image.asset(
                        'images/icon/AddTable.png',
                      )),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Table1_PriceScren();
                    }));
                  },
                ),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ชื่อ รายการอาหาร
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Text(
                      'รายการอาหาร ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // Tab bar
              TabBar(tabs: myTabs),

              // Tab bar view
              Expanded(
                  child: TabBarView(
                children: [
                  // ผัด
                  PuffTab1(),
                  // ต้ม
                  BoiledTab1(),
                  // ยำ
                  YumTab1(),
                  // เครื่องดื่ม
                  DrinkTab1(),
                ],
              ))
            ],
          )),
    );
  }
}
