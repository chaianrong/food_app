import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/profile_register.dart';
import 'package:food_app/screen_login/login_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final foemkey = GlobalKey<FormState>();
  ProFile profile = ProFile();
  String? typeUser;

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
                        // image
                        Container(
                          child: Image.asset("images/food.png"),
                          width: 400,
                          height: 300,
                        ),

                        // Text Register
                        Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ลงทะเบียนเพื่อเข้าสู่ระบบ',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        // email textfield
                        Padding(
                          // กำหนดความยาว ขอบ
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

                        // password textfield
                        Padding(
                          // กำหนดความยาว ขอบ
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
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อน Password'),
                            // ทำให้ password มองไม่เห็น
                            obscureText: true,
                            onSaved: (String? password) {
                              profile.password = password;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // เลือก User
                        Text(
                          "เลือก User",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                value: "เจ้าของร้าน",
                                groupValue: typeUser,
                                title: Text(
                                  'เจ้าของร้าน',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                dense: true,
                                onChanged: (Value) {
                                  setState(() {
                                    typeUser = Value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                value: "พนักงาน",
                                groupValue: typeUser,
                                title: Text(
                                  'พนักงาน',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                dense: true,
                                onChanged: (Value) {
                                  setState(() {
                                    typeUser = Value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        // sign in button
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
                                'Register',
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
                                        .createUserWithEmailAndPassword(
                                            email: profile.email!,
                                            password: profile.password!);
                                    foemkey.currentState!.reset();

                                    if (typeUser == null) {}
                                    // pop up แจ้งเตือน
                                    Fluttertoast.showToast(
                                        msg: 'สร้างบัญชีผู้ใช้เรียบร้อย',
                                        // ทิศทางการแสดง
                                        gravity: ToastGravity.TOP);

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    }));
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);

                                    var massage;
                                    if (e.code == 'email-already-in-use') {
                                      massage =
                                          'มี email อยู่ในระบบแล้ว โปรดใช้อีเมลอื่น';
                                    } else if (e.code == 'weak-password') {
                                      massage =
                                          'รหัสผ่านต้องมีความยาว 6 ตัวอักษร';
                                    } else {
                                      massage = e.message;
                                    }

                                    Fluttertoast.showToast(
                                        msg: massage,
                                        // ทิศทางการแสดง
                                        gravity: ToastGravity.TOP);
                                  }
                                }
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        // Not a member? Login now
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'back to page',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login now',
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
