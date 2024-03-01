import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table1/Table_1.dart';
import 'package:food_app/Table_screen/Table3/Table_3.dart';
import 'package:food_app/Table_screen/Table4/Table_4.dart';
import 'package:food_app/Table_screen/Table5/Table_5.dart';
import '../modify/modify.dart';
import '../screen_main_page/add_food.dart';
import 'Table2/Table_2.dart';

class TaBleScreen extends StatefulWidget {
  const TaBleScreen({super.key});

  @override
  State<TaBleScreen> createState() => _TaBleScreenState();
}

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
          title: Text(
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
                return AppFood();
              }),
            );
          },
        ),
        ListTile(
          leading: Container(
              width: 40,
              child: Image.asset(
                'images/icon/table.png',
              )),
          title: Text(
            'แก้ไขเมนู',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ModifyFood();
              }),
            );
          },
        ),
      ],
    ),
  );
}

class _TaBleScreenState extends State<TaBleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // widget หน้าต่างสำเร็จรูปสำหรับจัดการโครงสร้างของหน้าแอพ
      appBar: AppBar(
        title: Text('โต๊ะลูกค้า'),
        centerTitle: true, // ทำให้ตัวหนังสืออยู่ตรงกลาง
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10), // กำหนดระยะห่างจากขอบ
          child: Builder(builder: (context) {
            return IconButton(
              // สร้าง Icon ที่กดได้
              icon: Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
      ),
      // กดเพื่อไปสู้หน้าอื่น
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[buildHeader(context), buildMenuItems(context)],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              // ปุ่มเข้าสู้หน้าโต๊ะ 1
              Table(
                textTitle: 'โต๊ะ 1',
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TaBle1())),
              ),
              SizedBox(
                height: 15,
              ),
              // ปุ่มเข้าสู้หน้าโต๊ะ 2
              Table(
                textTitle: 'โต๊ะ 2',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const TaBle2();
                    }),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              // ปุ่มเข้าสู้หน้าโต๊ะ 3
              Table(
                textTitle: 'โต๊ะ 3',
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TaBle3())),
              ),
              SizedBox(
                height: 15,
              ),
              // ปุ่มเข้าสู้หน้าโต๊ะ 4
              Table(
                textTitle: 'โต๊ะ 4',
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TaBle4())),
              ),
              SizedBox(
                height: 15,
              ),
              // ปุ่มเข้าสู้หน้าโต๊ะ 5
              Table(
                textTitle: 'โต๊ะ 5',
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TaBle5())),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Table extends StatelessWidget {
  final String textTitle;
  final VoidCallback onTap;
  const Table({super.key, required this.textTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.blue[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textTitle,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
