import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Table_screen/table_screen.dart';
import 'package:food_app/model/add_model.dart';
import 'package:food_app/screen_main_page/home_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';

class AppFood extends StatefulWidget {
  const AppFood({super.key});

  @override
  State<AppFood> createState() => _AppFoodState();
}

class _AppFoodState extends State<AppFood> {
  final formkey = GlobalKey<FormState>();
  Addfood _addfood = Addfood();

  String MunuID = DateTime.now().microsecondsSinceEpoch.toString();

  ///// ที่เก็บข้อมมูลรูป ////
  String? imageUrl;

  File? _file;

  bool hasFood = true;

  SaveData(
      // String collectionName,
      String FoodType) {
    FirebaseFirestore.instance
        .collection('เมนูอาหาร')
        .doc("OR : ${MunuID}")
        .set({
      'MunuID': MunuID,
      "namefood": _addfood.namefood,
      "price": num.parse(_addfood.price!),
      "image": imageUrl,
      'status': hasFood,
      'FoodType': FoodType,
    }).then((value) {
      print('Save Complete');
    }).catchError((error) {
      print('Save Error $error');
    }).whenComplete(() {
      print('When Complete');
    });
  }

  void showSimpleDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('เลือกประเภทอาหาร'),
          children: <Widget>[
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              onPressed: () async {
                // สร้างชื่อไฟร์รูปที่ไม่ซ้ำ
                String uniqueFileName =
                    DateTime.now().microsecondsSinceEpoch.toString();

                // สร้างเส้นทางเก็บไฟร์รูปที่ Firebase
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                // อับโหลดชื่อไฟร์รูป
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                // เช็ค errors
                try {
                  // แสดง กำลังบันทึกข้อมูล... เมื่อกำลังบันทึกข้อมูล
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Row(children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text("กำลังบันทึกข้อมูล..."),
                      ]),
                    ),
                    // ปิดให้ไม่สามารถปิดได้
                    barrierDismissible: false,
                  );
                  // เก็บไฟร์
                  await referenceImageToUpload.putFile(_file!);

                  // รับ UPL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (errors) {}
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();

                  await SaveData(
                    'ผัด',
                  );

                  print(MunuID);
                  formkey.currentState!.reset();

                  Fluttertoast.showToast(
                      msg: 'สร้างเมนูอาหารเรียบร้อย',
                      // ทิศทางการแสดง
                      gravity: ToastGravity.TOP);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                }
              },
              child: Text('ผัด/ทอด'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              onPressed: () async {
                // สร้างชื่อไฟร์รูปที่ไม่ซ้ำ
                String uniqueFileName =
                    DateTime.now().microsecondsSinceEpoch.toString();

                // สร้างเส้นทางเก็บไฟร์รูปที่ Firebase
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                // อับโหลดชื่อไฟร์รูป
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                // เช็ค errors
                try {
                  // แสดง กำลังบันทึกข้อมูล... เมื่อกำลังบันทึกข้อมูล
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Row(children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text("กำลังบันทึกข้อมูล..."),
                      ]),
                    ),
                    // ปิดให้ไม่สามารถปิดได้
                    barrierDismissible: false,
                  );
                  // เก็บไฟร์
                  await referenceImageToUpload.putFile(_file!);

                  // รับ UPL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (errors) {}

                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  await SaveData('ต้ม');

                  print(MunuID);
                  formkey.currentState!.reset();

                  Fluttertoast.showToast(
                      msg: 'สร้างเมนูอาหารเรียบร้อย',
                      // ทิศทางการแสดง
                      gravity: ToastGravity.TOP);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                }
              },
              child: Text('ต้ม'),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              onPressed: () async {
                // สร้างชื่อไฟร์รูปที่ไม่ซ้ำ
                String uniqueFileName =
                    DateTime.now().microsecondsSinceEpoch.toString();

                // สร้างเส้นทางเก็บไฟร์รูปที่ Firebase
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                // อับโหลดชื่อไฟร์รูป
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                // เช็ค errors
                try {
                  // แสดง กำลังบันทึกข้อมูล... เมื่อกำลังบันทึกข้อมูล
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Row(children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text("กำลังบันทึกข้อมูล..."),
                      ]),
                    ),
                    // ปิดให้ไม่สามารถปิดได้
                    barrierDismissible: false,
                  );
                  // เก็บไฟร์
                  await referenceImageToUpload.putFile(_file!);

                  // รับ UPL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (errors) {}

                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  await SaveData('ยำ');

                  print(MunuID);
                  formkey.currentState!.reset();

                  Fluttertoast.showToast(
                      msg: 'สร้างเมนูอาหารเรียบร้อย',
                      // ทิศทางการแสดง
                      gravity: ToastGravity.TOP);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                }
              },
              child: Text('ยำ'),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              onPressed: () async {
                // สร้างชื่อไฟร์รูปที่ไม่ซ้ำ
                String uniqueFileName =
                    DateTime.now().microsecondsSinceEpoch.toString();

                // สร้างเส้นทางเก็บไฟร์รูปที่ Firebase
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                // อับโหลดชื่อไฟร์รูป
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                // เช็ค errors
                try {
                  // แสดง กำลังบันทึกข้อมูล... เมื่อกำลังบันทึกข้อมูล
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Row(children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text("กำลังบันทึกข้อมูล..."),
                      ]),
                    ),
                    // ปิดให้ไม่สามารถปิดได้
                    barrierDismissible: false,
                  );
                  // เก็บไฟร์
                  await referenceImageToUpload.putFile(_file!);

                  // รับ UPL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (errors) {}

                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  await SaveData('เครื่องดื่ม');

                  print(MunuID);
                  formkey.currentState!.reset();

                  Fluttertoast.showToast(
                      msg: 'สร้างเมนูอาหารเรียบร้อย',
                      // ทิศทางการแสดง
                      gravity: ToastGravity.TOP);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                }
              },
              child: Text('เครื่องดื่ม'),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มเมนู'),
      ),

      //////////////////// Body///////////////////////
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              ////////////////ชิดด้านขอบ////////////////
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: _file == null
                        ? Image.asset("images/Icon_photo.png")
                        : Image.file(_file!)),
                Container(
                  child:
                      ///////////////// เก็บข้อมูลรูปภาพ////////////////
                      IconButton(
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      print('${file?.path}');

                      ///////////////ตรวจสอบไฟร์รูปว่ามีค่าเท่ากับ Null ไหม //////////////////
                      if (file == null) return;

                      setState(() {
                        _file = File(file.path);
                      });
                    },
                    icon: const Icon(
                      Icons.add_photo_alternate,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // ใส่ชื่อเมนูอาหาร

                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'ชื่ออาหาร',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),

                  // ตรวจสอบว่าใส่ข้อมูลเเล้ว

                  validator: RequiredValidator(errorText: 'กรุณาใส่ข้อมูล'),
                  //////////////// เมื่อเปลี่ยนเปลงค่าจะดึงข้อมูลไปเก็บ ///////////
                  onSaved: (String? namefood) {
                    _addfood.namefood = namefood;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),

                /////////// ใส่ราคาเมนูอาหาร ////////////////
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'ราคา',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),

                  ///////////////// ตรวจสอบว่าใส่ข้อมูลเเล้ว /////////////
                  validator: RequiredValidator(errorText: 'กรุณาใส่ข้อมูล'),
                  keyboardType: TextInputType.number,

                  ///////////////// เมื่อเปลี่ยนเปลงค่าจะดึงข้อมูลไปเก็บ //////////////
                  onSaved: (String? price) {
                    _addfood.price = price;
                  },
                ),

                /////////////////// ปุ่มบันทึกข้อมูล ////////////////////
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      'บันทึก',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      showSimpleDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
