import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../tool/table_tile.dart';

class Table5_PriceScren extends StatefulWidget {
  Table5_PriceScren({
    super.key,
  });

  @override
  State<Table5_PriceScren> createState() => _Table5_PriceScrenState();
}

class _Table5_PriceScrenState extends State<Table5_PriceScren> {
  Future<num> _getTotalPrice() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('โต๊ะ')
        .where('table', isEqualTo: 'โต๊ะ 5')
        .get();

    num totalPrice = 0;
    snapshot.docs.forEach((doc) {
      totalPrice += doc['total'];
    });

    return totalPrice;
  }

  Future<void> _savePaymentData(num totalPrice) async {
    DateTime currentTime = DateTime.now();
    String paymentTime = currentTime.toString();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('โต๊ะ')
        .where('table', isEqualTo: 'โต๊ะ 5')
        .get();

    List<Map<String, dynamic>> foodItems = [];

    querySnapshot.docs.forEach((doc) {
      foodItems.add({
        'Foodname': doc['Foodname'],
        'total': doc['total'],
        'qty': doc['qty'],
        'MunuID': doc['MunuID'],
        'price': doc['price'],
      });
    });

    Map<String, dynamic> paymentData = {
      'totalPrice': totalPrice,
      'โต๊ะ': '5',
      'foodItems': foodItems,
    };

    await FirebaseFirestore.instance
        .collection('รายการชำระเงิน')
        .doc(paymentTime)
        .set(paymentData)
        .then((value) {
      print('บันทึกจำนวนเงินเรียบร้อยแล้ว: \$${totalPrice}');
    }).catchError((error) {
      print('เกิดข้อผิดพลาดในการบันทึกจำนวนเงิน: $error');
    });

    // ลบ Collection "โต๊ะ 1"
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
    print('ลบ Collection "โต๊ะ 5" สำเร็จ');

    // แสดงข้อความ "ชำระเงินเรียบร้อย"
    Fluttertoast.showToast(
      msg: 'ชำระเงินเรียบร้อย',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );

    // ย้อนกลับไปหน้าแรก
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('โต๊ะ 5')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('โต๊ะ')
            .where('table', isEqualTo: 'โต๊ะ 5')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return TableTile(
                      itemName: snapshot.data!.docs[index]['Foodname'],
                      itemPhoto: snapshot.data!.docs[index]['image'],
                      itemTotal: snapshot.data!.docs[index]['total'],
                      qty: snapshot.data!.docs[index]['qty'],
                      itemprice: snapshot.data!.docs[index]['price'],
                      MunuID: snapshot.data!.docs[index]['MunuID'],
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('โต๊ะ')
                            .doc(snapshot.data?.docs[index].id)
                            .delete()
                            .then((value) {
                          print(
                              'รายการสั่งซื้อที่ลบไปแล้ว: ${snapshot.data!.docs[index].id}');
                        }).catchError((error) {
                          print('ลบไม่สำเสร็จ : $error');
                        }).whenComplete(() {
                          print(
                              'whenComplete: ${snapshot.data!.docs[index].id}');
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ราคารวม
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ราคารวม',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          FutureBuilder<num>(
                            future: _getTotalPrice(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              return Text(
                                '\฿${snapshot.data}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ],
                      ),

                      // เลือกโต๊ะ
                      GestureDetector(
                        onTap: () {
                          _getTotalPrice().then((totalPrice) {
                            _savePaymentData(totalPrice);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade100),
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(12),
                          child: const Row(
                            children: [
                              Text(
                                'ชำระเงิน',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


// Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: ListTile(
//                               leading: CircleAvatar(
//                                   radius: 40,
//                                   backgroundImage: NetworkImage(
//                                     snapshot.data!.docs[index]['image'],
//                                   )),
//                               title: Text(
//                                 snapshot.data!.docs[index]['Foodname'],
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               subtitle: Text('\฿' +
//                                   snapshot.data!.docs[index]['price']
//                                       .toString()),
//                               trailing: IconButton(
//                                 onPressed: () {
//                                   FirebaseFirestore.instance
//                                       .collection('SaceOrder')
//                                       .doc(snapshot.data?.docs[index].id)
//                                       .delete()
//                                       .then((value) {
//                                     print(
//                                         'รายการสั่งซื้อที่ลบไปแล้ว: ${snapshot.data!.docs[index].id}');
//                                   }).catchError((error) {
//                                     print('ลบไม่สำเสร็จ : $error');
//                                   }).whenComplete(() {
//                                     print(
//                                         'whenComplete: ${snapshot.data!.docs[index].id}');
//                                   });
//                                 },
//                                 icon: Icon(
//                                   Icons.cancel,
//                                 ),
//                               )),
//                         ),
//                       );

// TableTile(
//                         itemName: snapshot.data!.docs[index]['Foodname'],
//                         itemPhoto: snapshot.data!.docs[index]['image'],
//                         itemPrice: snapshot.data!.docs[index]['price'],
//                         qty: snapshot.data!.docs[index]['qty'],
//                         onPressed: () {
//                           FirebaseFirestore.instance
//                               .collection('SaceOrder')
//                               .doc(snapshot.data?.docs[index].id)
//                               .delete()
//                               .then((value) {
//                             print(
//                                 'รายการสั่งซื้อที่ลบไปแล้ว: ${snapshot.data!.docs[index].id}');
//                           }).catchError((error) {
//                             print('ลบไม่สำเสร็จ : $error');
//                           }).whenComplete(() {
//                             print(
//                                 'whenComplete: ${snapshot.data!.docs[index].id}');
//                           });
//                         },
                        
//                       );