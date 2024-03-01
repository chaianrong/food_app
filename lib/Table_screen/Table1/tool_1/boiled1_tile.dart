import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// คลาส BoiledTile1 เป็น StatefulWidget ที่ใช้สำหรับแสดงรายการสินค้า
class BoiledTile1 extends StatefulWidget {
  final String itemName; // ชื่อสินค้า
  final num itemPrice; // ราคาสินค้า
  final String itemPhoto; // URL รูปภาพสินค้า
  final String MunuID; // ID สินค้า
  final bool status; // สถานะสินค้า

  // กำหนดค่าพารามิเตอร์ให้กับตัวแปรในคลาส
  BoiledTile1({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemPhoto,
    required this.MunuID,
    required this.status,
  });

  @override
  State<BoiledTile1> createState() => _BoiledTileState();
}

// เมื่อสถานะของสินค้าเปลี่ยนแปลง หรือมีการเรียกใช้ setState จะทำการอัปเดตหน้าจอ
class _BoiledTileState extends State<BoiledTile1> {
  int _count = 1; // จำนวนสินค้าที่ถูกเลือก
  // เพิ่มจำนวนสินค้า
  void AddCont() {
    setState(() {
      _count++;
    });
  }

  // ลดจำนวนสินค้า
  void RemoveCont() {
    if (_count <= 1) {
      return;
    }
    setState(() {
      _count--;
    });
  }

  // รีเซ็ตจำนวนสินค้า
  void Reset() {
    setState(() {
      _count = 1;
    });
  }

  // บันทึกออเดอร์ในฐานข้อมูล Firestore
  void SaveOrder() {
    FirebaseFirestore.instance
        .collection('โต๊ะ')
        .doc("TB1 : ${widget.MunuID}")
        .set({
      'MunuID': widget.MunuID,
      'Foodname': widget.itemName,
      'price': widget.itemPrice,
      'image': widget.itemPhoto,
      'qty': _count,
      'total': totals(),
      'table': 'โต๊ะ 1'
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

  // คำนวณราคารวมของสินค้า
  num totals() {
    num total = 0;
    total = widget.itemPrice * _count;
    print(total);
    return total;
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
