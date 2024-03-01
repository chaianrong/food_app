import 'package:cloud_firestore/cloud_firestore.dart';

class MenuModel {
  final String? MunuID;
  final String? itemName;
  final String? itemPhoto;
  final num? itemPrice;

  MenuModel({this.MunuID, this.itemName, this.itemPhoto, this.itemPrice});

// Save DATA
  Map<String, dynamic> toFireStore() => {
        'MunuID': MunuID,
        'image': itemPhoto,
        'namefood': itemName,
        'price': itemPrice
      };

  Stream<QuerySnapshot> getMenu() {
    return FirebaseFirestore.instance.collection('กาแฟ').snapshots();
  }

  factory MenuModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return MenuModel(
        MunuID: data['MunuID'],
        itemName: data['namefood'],
        itemPhoto: data['image'],
        itemPrice: data['price']);
  }
}
