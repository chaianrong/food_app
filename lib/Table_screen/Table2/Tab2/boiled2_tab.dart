import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table2/tool_2/boiled2_tile.dart';

class BoiledTab2 extends StatelessWidget {
  BoiledTab2({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('เมนูอาหาร')
            .where('FoodType', isEqualTo: 'ต้ม')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.7),
              itemBuilder: (context, index) {
                return BoiledTile2(
                  itemName: snapshot.data!.docs[index]['namefood'],
                  itemPhoto: snapshot.data!.docs[index]['image'],
                  itemPrice: snapshot.data!.docs[index]['price'],
                  MunuID: snapshot.data!.docs[index]['MunuID'],
                  status: snapshot.data!.docs[index]['status'],
                );
              });
        });
  }
}
