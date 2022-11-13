import 'package:flutter/material.dart';

import 'package:workapp/data/sqldb.dart';
import 'package:workapp/employee/score.dart';
import 'package:workapp/employee/service_employee.dart';
import 'package:workapp/screens/login_screen.dart';

class ListEmploye extends StatefulWidget {
  const ListEmploye({super.key});

  @override
  State<ListEmploye> createState() => _ListEmployeState();
}

class _ListEmployeState extends State<ListEmploye> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM persons");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الصفحة الرئيسية'),
            actions: [
              PopupMenuButton<int>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("الحضور"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("الخروج"),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text("الخروج"),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: screenHeight / 4,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2B4865),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 100),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ServiceEmployee(
                            title: 'المدير',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      padding: const EdgeInsets.only(right: 20, left: 20),
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
                      child: Row(
                        children: [
                          Image.asset(
                            'images/boss.jpg',
                            height: 70,
                          ),
                          const SizedBox(width: 40),
                          const Text(
                            'المدير',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: FutureBuilder(
                        future: readData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Map>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                              padding: const EdgeInsets.only(
                                  top: 50, bottom: 100, left: 10, right: 10),
                              itemCount: snapshot.data!.length,
                              separatorBuilder: ((context, index) {
                                return const SizedBox(height: 30);
                              }),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ServiceEmployee(
                                          title: snapshot.data![index]
                                              ['first_name'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20),
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
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'images/person.png',
                                          height: 70,
                                        ),
                                        const SizedBox(width: 40),
                                        Text(
                                          snapshot.data![index]['first_name'],
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Score()));
            },
            child: const Icon(
              Icons.av_timer,
              size: 42,
            ),
          ),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        DateTime nowDate = DateTime.now();
        String entreTime =
            '${nowDate.year}-${nowDate.month}-${nowDate.day} ${nowDate.hour}:${nowDate.minute}';

        int response = await sqlDb.insertData('''
                            INSERT INTO "access" ("access")
                            VALUES ("$entreTime")
                            ''');
        print('access=======================$response');
        print(entreTime);

        break;
      case 1:
        DateTime nowDate = DateTime.now();
        String exitTime =
            '${nowDate.year}-${nowDate.month}-${nowDate.day} ${nowDate.hour}:${nowDate.minute}';

        int response = await sqlDb.insertData('''
                            INSERT INTO "exit" ("exit")
                            VALUES ("$exitTime")
                            ''');
        print('exit=======================$response');
        print(exitTime);
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
        break;
    }
  }
}
