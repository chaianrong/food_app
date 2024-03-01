import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "../controllers/order_model.dart";

class TableTile extends StatelessWidget {
  final int qty; // จำนวน
  final String itemName; // ชื่อ
  final String itemPhoto; // รูป
  final num itemprice; // ราคา
  final num itemTotal; // ราคารวม
  final String MunuID; // ID
  final VoidCallback onPressed;

  TableTile(
      {required this.itemName,
      required this.itemTotal,
      required this.itemPhoto,
      required this.qty,
      required this.MunuID,
      required this.itemprice,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(itemPhoto),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            '\฿' + itemprice.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text('X' + qty.toString(),
                              style: TextStyle(fontSize: 15)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(itemName, style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Text('฿ ' + itemTotal.toString())
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
