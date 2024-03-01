import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table3/Tab3/drink3_tab.dart';
import 'package:food_app/Table_screen/Table3/Tab3/yum3_tab.dart';
import 'package:food_app/Table_screen/Table3/Tab3/puff3_tab.dart';
import 'package:food_app/Table_screen/Table3/Tab3/boiled3_tab.dart';
import 'package:food_app/Table_screen/Table3/Table3_price_scren.dart';
import 'package:food_app/tool/my_teb.dart';

import '../../screen_main_page/add_food.dart';

class TaBle3 extends StatefulWidget {
  const TaBle3({
    super.key,
  });

  @override
  State<TaBle3> createState() => _TaBle3State();
}

class _TaBle3State extends State<TaBle3> {
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

  buildHeader(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 80, 156, 223),
      padding: EdgeInsets.only(
          top: 10 + MediaQuery.of(context).padding.top, bottom: 20),
      child: const Column(children: [
        Icon(
          Icons.account_circle,
          size: 100,
        ),
        SizedBox(height: 5),
        Text(
          'User',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        Text(
          'Email',
          style: TextStyle(fontSize: 18, color: Colors.white),
        )
      ]),
    );
  }

  buildMenuItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Container(
                width: 40,
                child: Image.asset(
                  'images/icon/AddFood.png',
                )),
            title: const Text(
              'เพิ่มเมนูอาหาร',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const AppFood();
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'โต๊ะ 3',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                      return Table3_PriceScren();
                    }));
                  },
                ),
              )
            ],
          ),

          // AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   leading: Padding(
          //     padding: EdgeInsets.only(left: 10),
          //     child: Builder(builder: (context) {
          //       return IconButton(
          //         icon: Icon(
          //           Icons.menu,
          //           color: Colors.grey[800],
          //           size: 30,
          //         ),
          //         onPressed: () {},
          //       );
          //     }),
          //   ),
          //   actions: [
          //     Padding(
          //       padding: EdgeInsets.only(right: 10),
          //       child: IconButton(
          //         icon: Container(
          //             width: 50,
          //             child: Image.asset(
          //               'images/icon/AddTable.png',
          //             )),
          //         onPressed: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) {
          //             return TaBle3_PriceScren();
          //           }));
          //         },
          //       ),
          //     )
          //   ],
          // ),
          // drawer: Drawer(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: <Widget>[
          //         buildHeader(context),
          //         buildMenuItems(context)
          //       ],
          //     ),
          //   ),
          // ),
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
                  PuffTab3(),
                  // ต้ม
                  BoiledTab3(),
                  // ยำ
                  YumTab3(),
                  // เครื่องดื่ม
                  DrinkTab3(),
                ],
              ))
            ],
          )),
    );
  }
}
