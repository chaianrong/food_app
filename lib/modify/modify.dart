import 'package:flutter/material.dart';
import '../tool/my_teb.dart';
import 'modify_tab/boiled_tab.dart';
import 'modify_tab/drink_tab.dart';
import 'modify_tab/puff_tab.dart';
import 'modify_tab/yum_tab.dart';

class ModifyFood extends StatefulWidget {
  const ModifyFood({
    super.key,
  });

  @override
  State<ModifyFood> createState() => _ModifyFoodState();
}

class _ModifyFoodState extends State<ModifyFood> {
  List<Widget> myTabs = [
    // อาหารจารเดียว
    const MyTeb(
      iconPath: 'images/icon/ผัด.png',
      tebname: ('ผัด/ทอด'),
    ),

    // กับข้าว
    const MyTeb(
      iconPath: 'images/icon/ต้ม.png',
      tebname: ('ต้ม'),
    ),
    // เครื่องดื่ม
    const MyTeb(
      iconPath: 'images/icon/ยำ.png',
      tebname: ('ยำ'),
    ),
    // กาแฟ
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
              'ตั้งค่าเมนู',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            // แสดง Icon ด้านซ้าย
            leading: Padding(
              padding: EdgeInsets.only(left: 10),
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
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // รายการ
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
                  PuffTab(),
                  // ต้ม
                  BoiledTab(),
                  // ยำ
                  YumTab(),
                  // เครื่องดื่ม
                  DrinkTab(),
                ],
              ))
            ],
          )),
    );
  }
}
