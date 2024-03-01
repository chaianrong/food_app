import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class OrderModel {
  List<OrderItemInfo>? listOrderItemInfo;
  OrderModel({this.listOrderItemInfo});
  Map<String, dynamic> toFireStore() {
    return {
      'listOrderItemInfo':
          List<dynamic>.from(listOrderItemInfo!.map((e) => e.toFireStore()))
    };
  }

  SaveOrder() {
    FirebaseFirestore.instance
        .collection('โต๊ะ')
        .doc()
        .set(this.toFireStore())
        .then((value) {
      print('SAVED ORDER COMPLETED');
    }).catchError((error) {
      print('SAVED ERROR $error COMPLETED');
    }).whenComplete(() {
      print('WHEN COMPLATED "FINALLY"');
      print("WHEN COMPLATED 'FINALLY'");
    });
  }
}

class OrderItemInfo {
  final String? Foodname;
  final String? MunuID;
  final String? image;
  final num? price;
  final int? qty;
  OrderItemInfo({this.Foodname, this.MunuID, this.image, this.price, this.qty});
  Map<String, dynamic> toFireStore() {
    return {
      'Foodname': Foodname,
      'MunuID': MunuID,
      'image': image,
      'price': price,
      'qty': qty
    };
  }
}
