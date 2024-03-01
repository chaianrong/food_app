import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Table_screen/Table3/tool_3/boiled3_tile.dart';

class BoiledTab3 extends StatelessWidget {
  BoiledTab3({super.key});

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
                return BoiledTile3(
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
