import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../modify_tool/puff_tile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PuffTab extends StatelessWidget {
  PuffTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('เมนูอาหาร')
            .where('FoodType', isEqualTo: 'ผัด')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.8),
              itemBuilder: (context, index) {
                final document = snapshot.data!.docs[index];
                final itemId = document.id;
                final itemPhoto = document['image'];
                return puffTile(
                  itemName: snapshot.data!.docs[index]['namefood'],
                  itemPhoto: snapshot.data!.docs[index]['image'],
                  itemPrice: snapshot.data!.docs[index]['price'],
                  MunuID: snapshot.data!.docs[index]['MunuID'],
                  status: snapshot.data!.docs[index]['status'],
                  onPressed: () {
                    // ลบรูปภาพจาก Storage
                    firebase_storage.FirebaseStorage.instance
                        .refFromURL(itemPhoto)
                        .delete()
                        .then((delete) {
                      // ลบเอกสารในคอลเลกชัน Firestore
                      FirebaseFirestore.instance
                          .collection('เมนูอาหาร')
                          .doc(itemId)
                          .delete()
                          .then((delete) {
                        print('รายการที่ลบไปแล้ว: $itemId');
                      }).catchError((error) {
                        print('ลบไม่สำเสร็จ : $error');
                      });
                    }).catchError((error) {
                      print('ลบรูปไม่สำเสร็จ : $error');
                    });
                  },
                );
              });
        });
  }
}
