import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table1/tool_1/puff1_tile.dart';

class PuffTab1 extends StatelessWidget {
  PuffTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // กำหนด stream เพื่อติดตามการเปลี่ยนแปลงของคอลเลกชัน 'ผัด|ทอด' ใน Cloud Firestore
        stream: FirebaseFirestore.instance
            .collection('เมนูอาหาร')
            .where('FoodType', isEqualTo: 'ผัด')
            .snapshots(),
        builder: (context, snapshot) {
          // ตรวจสอบว่ามีข้อมูลหรือไม่
          if (!snapshot.hasData) {
            return Center(
                child:
                    CircularProgressIndicator()); // แสดง CircularProgressIndicator เมื่อไม่มีข้อมูล
          }

          // สร้าง GridView โดยใช้ snapshot ที่ได้จาก Firestore
          return GridView.builder(
              itemCount:
                  snapshot.data!.docs.length, // กำหนดจำนวนรายการใน GridView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.7), // กำหนดการแสดงผลตารางกริด
              itemBuilder: (context, index) {
                // สร้าง puffTile1 สำหรับแสดงข้อมูลแต่ละรายการ
                return puffTile1(
                  itemName: snapshot.data!.docs[index]
                      ['namefood'], // ส่งชื่ออาหารไปยัง puffTile1
                  itemPhoto: snapshot.data!.docs[index]
                      ['image'], // ส่งรูปภาพอาหารไปยัง puffTile1
                  itemPrice: snapshot.data!.docs[index]
                      ['price'], // ส่งราคาอาหารไปยัง puffTile1
                  MunuID: snapshot.data!.docs[index]
                      ['MunuID'], // ส่ง ID ของเมนูไปยัง puffTile1
                  status: snapshot.data!.docs[index]
                      ['status'], // ส่งสถานะอาหารไปยัง puffTile1
                );
              });
        });
  }
}
