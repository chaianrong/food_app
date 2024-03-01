import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class puffTile extends StatefulWidget {
  final String itemName; // ชื่อสินค้า
  final num itemPrice; // ราคาสินค้า
  final String itemPhoto; // รูปภาพสินค้า
  final String MunuID; // รหัสสินค้า
  final VoidCallback onPressed; // ฟังก์ชันเมื่อกดปุ่มลบ
  final bool status; // สถานะของสินค้า

  puffTile(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemPhoto,
      required this.MunuID,
      required this.onPressed,
      required this.status});

  @override
  State<puffTile> createState() => _puffTileState();
}

class _puffTileState extends State<puffTile> {
  bool hasFood = true; // สถานะ "มี" ของสินค้า
  bool nofood = false; // สถานะ "หมด" ของสินค้า

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.status ? Colors.grey[200] : Colors.grey[500],
          borderRadius: BorderRadius.circular(12), // มุมโค้งของ container
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ปุ่มลบสินค้า
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: 30,
                  ),
                  onPressed: widget.onPressed,
                ),
              ],
            ),

            // รูปภาพสินค้า
            Container(
              width: 140,
              child: Image.network(
                widget.itemPhoto,
                fit: BoxFit.contain,
              ),
            ),

            // ชื่อสินค้า
            Text(
              widget.itemName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),

            // ปุ่มปรับสถานะสินค้าเป็น "มี"
            MaterialButton(
              color: Colors.black,
              child: Text(
                'มี',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // อัปเดตสถานะของสินค้าใน Firebase Firestore เป็น "มี"
                FirebaseFirestore.instance
                    .collection('เมนูอาหาร')
                    .doc("OR : ${widget.MunuID}")
                    .update({'status': hasFood}).then((value) {
                  print('Save Complete');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('อาหาร ${widget.itemName} มีอยู่'),
                    ),
                  );
                }).catchError((error) {
                  print('Save Error $error');
                }).whenComplete(() {
                  print('When Complete');
                });
              },
            ),

            // ปุ่มปรับสถานะสินค้าเป็น "หมด"
            MaterialButton(
              color: Colors.black,
              child: Text(
                'หมด',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // อัปเดตสถานะของสินค้าใน Firebase Firestore เป็น "หมด"
                FirebaseFirestore.instance
                    .collection('เมนูอาหาร')
                    .doc("OR : ${widget.MunuID}")
                    .update({'status': nofood}).then((value) {
                  print('Save Complete');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('อาหาร ${widget.itemName} หมด'),
                    ),
                  );
                }).catchError((error) {
                  print('Save Error $error');
                }).whenComplete(() {
                  print('When Complete');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


// ปุ่มลบ
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     IconButton(
          //       icon: Icon(
          //         Icons.cancel,
          //         size: 30,
          //       ),
          //       onPressed: widget.onPressed,
          //     )
          //   ],
          // ),
          // // image
          // Container(
          //     width: 140,
          //     child: Image.network(
          //       widget.itemPhoto!,
          //       fit: BoxFit.contain,
          //     )),