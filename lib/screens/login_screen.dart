import 'package:flutter/material.dart';
import 'package:workapp/employee/list_employee.dart';
import 'package:workapp/screens/forgot_sreen.dart';
import 'package:workapp/admin/list_persons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String name = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('تسجيل الدخول'),
            centerTitle: true,
          ),
          body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: screenHeight / 2.6,
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2B4865),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(80),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight / 4,
                  child: Container(
                    height: screenHeight * 0.40,
                    width: screenWidth * 0.75,
                    decoration: const BoxDecoration(
                      color: Color(0xFF256D85),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          offset: Offset(4, 8),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: globalKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                onChanged: (value) {
                                  name = value;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: 'اسم المستخدم',
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                onChanged: (value) {
                                  password = value;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _obscureText,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: 'كلمة المرور',
                                    contentPadding: const EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: Icon(_obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility))),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ForgorScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'نسيت كلمة المرور',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF002B5B),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              onPressed: () {
                                if (name == 'admin' && password == 'admin') {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const ListPersons(),
                                    ),
                                  );
                                }

                                // for employee
                                else if (name == 'user' && password == 'user') {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const ListEmploye(),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('تسجيل الدخول'),
                                      content: const Text(
                                        'أرجو التأكد من اسم المستخدم و كلمة المرور',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('حسنا'))
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: const Text('دخول'),
                            ),
                          ],
                        ),
                      ),
                    ),
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
