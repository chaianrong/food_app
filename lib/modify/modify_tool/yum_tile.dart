import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class YumTile extends StatefulWidget {
  final String itemName; // ชื่อ
  final num itemPrice; // ราคา
  final String itemPhoto; // รูป
  final String MunuID; // ID
  final VoidCallback onPressed;
  final bool status;

  YumTile(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemPhoto,
      required this.MunuID,
      required this.onPressed,
      required this.status});

  @override
  State<YumTile> createState() => _YumTileState();
}

class _YumTileState extends State<YumTile> {
  bool hasFood = true;
  bool nofood = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: widget.status ? Colors.grey[200] : Colors.grey[500],
            borderRadius: BorderRadius.circular(12) // มุมโค้ง
            ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // ปุ่มลบ
          // ปุ่มลบ
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 30,
                ),
                onPressed: widget.onPressed,
              )
            ],
          ),
          // image
          Container(
              width: 140,
              child: Image.network(
                widget.itemPhoto,
                fit: BoxFit.contain,
              )),

          // ชื่อ
          Text(
            widget.itemName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),

          // ปุ่มปรับสถานะ
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
              }),

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
              }),
        ]),
      ),
    );
  }
}


//  Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.cancel,
//                   size: 30,
//                 ),
//                 onPressed: widget.onPressed,
//               )
//             ],
//           ),
//           // image
//           Container(width: 140, child: Image.network(widget.itemPhoto!)),