import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table1/tool_1/drink1_tile.dart';

class DrinkTab1 extends StatelessWidget {
  DrinkTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // กำหนด stream เพื่อติดตามการเปลี่ยนแปลงของคอลเลกชัน 'เครื่องดื่ม' ใน Cloud Firestore
        stream: FirebaseFirestore.instance
            .collection('เมนูอาหาร')
            .where('FoodType', isEqualTo: 'เครื่องดื่ม')
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
                return DrinkTile1(
                  itemName: snapshot.data!.docs[index]
                      ['namefood'], // ส่งชื่อเครื่องดื่มไปยัง DrinkTile1
                  itemPhoto: snapshot.data!.docs[index]
                      ['image'], // ส่งรูปภาพเครื่องดื่มไปยัง DrinkTile1
                  itemPrice: snapshot.data!.docs[index]
                      ['price'], // ส่งราคาเครื่องดื่มไปยัง DrinkTile1
                  MunuID: snapshot.data!.docs[index]
                      ['MunuID'], // ส่ง ID ของเมนูไปยัง DrinkTile1
                  status: snapshot.data!.docs[index]
                      ['status'], // ส่งสถานะเครื่องดื่มไปยัง DrinkTile1
                );
              });
        });
  }
}
