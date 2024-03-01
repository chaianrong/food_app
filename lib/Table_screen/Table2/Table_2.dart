import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table2/Tab2/drink2_tab.dart';
import 'package:food_app/Table_screen/Table2/Tab2/Yum2_tab.dart';
import 'package:food_app/Table_screen/Table2/Tab2/puff2_tab.dart';
import 'package:food_app/Table_screen/Table2/Tab2/boiled2_tab.dart';
import 'package:food_app/Table_screen/Table2/Table2_price_scren.dart';
import '../../Tab/coffee_tab.dart';
import '../../Tab/drink_tab.dart';
import '../../Tab/order_tab.dart';
import '../../Tab/side_dish_tab.dart';
import '../../screen_main_page/add_food.dart';
import '../../tool/my_teb.dart';

class TaBle2 extends StatefulWidget {
  const TaBle2({
    super.key,
  });

  @override
  State<TaBle2> createState() => _TaBle2State();
}

class _TaBle2State extends State<TaBle2> {
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
              'โต๊ะ 2',
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
                      return Table2_PriceScren();
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
          //             return Table2_PriceScren();
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
                  PuffTab2(),
                  // ต้ม
                  BoiledTab2(),
                  // ยำ
                  YumTab2(),
                  // เครื่องดื่ม
                  DrinkTab2(),
                ],
              ))
            ],
          )),
    );
  }
}
