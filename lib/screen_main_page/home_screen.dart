// import 'package:flutter/material.dart';
// import 'package:food_app/Tab/coffee_tab.dart';
// import 'package:food_app/Tab/drink_tab.dart';
// import 'package:food_app/Tab/order_tab.dart';
// import 'package:food_app/Tab/side_dish_tab.dart';
// import 'package:food_app/screen_main_page/add_food.dart';
// import 'package:food_app/Table_screen/Table1/Table1_price_scren.dart';

// import 'package:food_app/tool/my_teb.dart';

// import '../Table_screen/table_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Widget> myTabs = [
//     // อาหารจารเดียว
//     const MyTeb(
//       iconPath: 'images/icon/restaurant.png',
//       tebname: ('ข้าวผัด'),
//     ),

//     // กับข้าว
//     const MyTeb(
//       iconPath: 'images/icon/cooked_to_order.png',
//       tebname: ('ต้ม'),
//     ),
//     // เครื่องดื่ม
//     const MyTeb(
//       iconPath: 'images/icon/soft_drink.png',
//       tebname: ('ทอด'),
//     ),
//     // กาแฟ
//     const MyTeb(
//       iconPath: 'images/icon/coffee.png',
//       tebname: ('เครื่องดื่ม'),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: myTabs.length,
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             leading: Padding(
//               padding: EdgeInsets.only(left: 10),
//               child: Builder(builder: (context) {
//                 return IconButton(
//                   icon: Icon(
//                     Icons.menu,
//                     color: Colors.grey[800],
//                     size: 30,
//                   ),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                 );
//               }),
//             ),
//             actions: [
//               Padding(
//                 padding: EdgeInsets.only(right: 10),
//                 child: IconButton(
//                   icon: Container(
//                       width: 50,
//                       child: Image.asset(
//                         'images/icon/AddTable.png',
//                       )),
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       return Container();
//                     }));
//                   },
//                 ),
//               )
//             ],
//           ),
//           drawer: Drawer(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   buildHeader(context),
//                   buildMenuItems(context)
//                 ],
//               ),
//             ),
//           ),
//           body: Column(
//               // children: [
//               //   // รายการ
//               //   const Padding(
//               //     padding: EdgeInsets.only(left: 20, top: 10),
//               //     child: Row(
//               //       children: [
//               //         Text(
//               //           'รายการอาหาร',
//               //           style:
//               //               TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               //   const SizedBox(
//               //     height: 15,
//               //   ),

//               //   // Tab bar
//               //   TabBar(tabs: myTabs),

//               //   // Tab bar view
//               //   Expanded(
//               //       child: TabBarView(
//               //     children: [
//               //       // อาหารจารเดียว
//               //       // OrderTab(),
//               //       // กับข้าว
//               //       //SideDishTab(),
//               //       // เครื่องดื่ม
//               //       // DrinkTab(),
//               //       // กาแฟ
//               //       //CoffeeTab(),
//               //     ],
//               //   ))
//               // ],
//               )),
//     );
//   }

//   buildHeader(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(255, 80, 156, 223),
//       padding: EdgeInsets.only(
//           top: 10 + MediaQuery.of(context).padding.top, bottom: 20),
//       child: const Column(children: [
//         Icon(
//           Icons.account_circle,
//           size: 100,
//         ),
//         SizedBox(height: 5),
//         Text(
//           'User',
//           style: TextStyle(fontSize: 30, color: Colors.white),
//         ),
//         Text(
//           'Email',
//           style: TextStyle(fontSize: 18, color: Colors.white),
//         )
//       ]),
//     );
//   }

//   buildMenuItems(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(24),
//       child: Wrap(
//         runSpacing: 16,
//         children: [
//           ListTile(
//             leading: Container(
//                 width: 40,
//                 child: Image.asset(
//                   'images/icon/AddFood.png',
//                 )),
//             title: const Text(
//               'เพิ่มเมนูอาหาร',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             onTap: () {
//               Navigator.pop(context);

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) {
//                   return const AppFood();
//                 }),
//               );
//             },
//           ),
//           ListTile(
//             leading: Container(
//                 width: 40,
//                 child: Image.asset(
//                   'images/icon/table.png',
//                 )),
//             title: Text(
//               'โต๊ะลูกค้า',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             onTap: () {
//               Navigator.pop(context);

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) {
//                   return TaBleScreen();
//                 }),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
