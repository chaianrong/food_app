import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/screen_login/register_screen.dart';
import 'package:food_app/screen_main_page/home_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../Table_screen/table_screen.dart';
import '../model/profile_register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final foemkey = GlobalKey<FormState>();
  ProFile profile = ProFile();

  // เตรียมฐานข้อมู firebase
  final Future<FirebaseApp> frirebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: frirebase,

        // ถ้าไม่สามารถทำงานกับ Firebase ได้
        builder: (context, snapshot) {
          // แจ้ง Error
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text('${snapshot.error}')),
            );
          }

          // เชื่อมต่อ Firebase ได้
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Color.fromARGB(255, 90, 90, 90),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Form(
                  key: foemkey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // โลโก้แอพ
                        Container(
                          child: Image.asset("images/food.png"),
                          width: 400,
                          height: 300,
                        ),

                        // ข้อความ Log In
                        Text(
                          'Log In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),

                        SizedBox(height: 10),

                        // กรอง Email ผู้ใช้งาน
                        Padding(
                          // แต่งที่กรอก Email ผู้ใช้งาน
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 166, 104, 247)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  labelText: 'Email',
                                  focusColor: Color.fromARGB(255, 0, 0, 0),
                                  filled: true,
                                  fillColor:
                                      Color.fromARGB(255, 255, 255, 255)),
                              // ตรวจสอบความถูกต้องของ Email
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'กรุณาป้อน Email'),
                                EmailValidator(
                                    errorText: 'กรุณาใส่ Email ให้ถูกต้อง')
                              ]),

                              //ตั้งค่า Keyboary
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? email) {
                                profile.email = email;
                              }),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        // กรอก password
                        Padding(
                          // แต่งที่กรอก password
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 166, 104, 247)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'password',
                                focusColor: Color.fromARGB(255, 0, 0, 0),
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255)),

                            // ตรวจสอบความถูกต้องของ password
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อน Password'),

                            // ทำให้ไม่เห็น password ที่กรอกลงไป
                            obscureText: true,
                            onSaved: (String? password) {
                              profile.password = password;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        // ปุ่มเข้าสู้ระบบ sign
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: SizedBox(
                            width: 250,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15)),
                                backgroundColor:
                                    Color.fromARGB(255, 203, 98, 245),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (foemkey.currentState!.validate()) {
                                  foemkey.currentState!.save();

                                  // ตรวจสอบความถูกต้องของ Email และ Passwoed
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email!,
                                            password: profile.password!)
                                        .then((value) {
                                      foemkey.currentState!.reset();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return TaBleScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                    var massage;
                                    if (e.code == 'user-not-found') {
                                      massage = 'ไม่พบผู้ใช้งาน';
                                    } else if (e.code == 'wrong-password') {
                                      massage =
                                          'รหัสผ่านผิดกณุณาใส่ใหม่อีกครั้ง';
                                    } else if (e.code == 'too-many-requests') {
                                      massage =
                                          'รหัสผ่านผิดกณุณาใส่ใหม่อีกครั้ง';
                                    } else {
                                      massage = e.message;
                                    }
                                    Fluttertoast.showToast(
                                      msg: massage,

                                      // การแสดงแจ้งเตือน
                                      gravity: ToastGravity.TOP,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        // ไปหน้าสมัครผู้ใช้งาน
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterScreen();
                                }));
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
