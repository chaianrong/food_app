import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BoiledTile2 extends StatefulWidget {
  final String itemName; // ชื่อ
  final num itemPrice; // ราคา
  final String itemPhoto; // รูป
  final String MunuID; // ID
  final bool status;

  BoiledTile2(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemPhoto,
      required this.MunuID,
      required this.status});

  @override
  State<BoiledTile2> createState() => _BoiledTileState();
}

class _BoiledTileState extends State<BoiledTile2> {
  SaveOrder() {
    FirebaseFirestore.instance
        .collection('โต๊ะ')
        .doc("TB2 : ${widget.MunuID}")
        .set({
      'MunuID': widget.MunuID,
      'Foodname': widget.itemName,
      'price': widget.itemPrice,
      'image': widget.itemPhoto,
      'qty': _count,
      'total': totals(),
      'table': 'โต๊ะ 2'
    }).then((value) {
      Fluttertoast.showToast(
        msg: 'บันทึก ${widget.itemName} เรียบร้อยแล้ว',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      print('Save Complete');
    }).catchError((error) {
      print('Save Error $error');
    }).whenComplete(() {
      print('When Complete');
    });
    print('เท่ากับ ${widget.MunuID}');
  }

  totals() {
    num total = 0;
    total = widget.itemPrice * _count;
    print(total);
    return total;
  }

  int _count = 1;

  void AddCont() {
    setState(() {
      _count++;
    });
  }

  void RemoveCont() {
    if (_count <= 1) {
      return;
    }
    setState(() {
      _count--;
    });
  }

  void Reset() {
    setState(() {
      _count = 1;
    });
    print(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            // ปรับสีพื้นหลังของ Container ตามเงื่อนไข status
            color: widget.status ? Colors.grey[200] : Colors.grey[500],
            borderRadius: BorderRadius.circular(12) // มุมโค้ง
            ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // image
          Container(width: 140, child: Image.network(widget.itemPhoto)),

          // ชื่อ
          Text(
            widget.itemName,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          //เพิ่ม + ลบ ออเดอร์
          widget.status
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.remove_circle, size: 30),
                        onPressed: RemoveCont),
                    Text(
                      _count.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          size: 30,
                        ),
                        onPressed: AddCont)
                  ],
                )
              : Text('อาหารหมด',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.red)),

          // ราคา + ปุ่ม
          MaterialButton(
              color: widget.status ? Colors.black : Colors.grey,
              child: Text(
                '\฿' + widget.itemPrice.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: widget.status
                  ? () {
                      SaveOrder();
                      Reset();
                    }
                  : null),
        ]),
      ),
    );
  }
}
