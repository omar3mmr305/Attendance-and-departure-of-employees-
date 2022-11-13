import 'package:flutter/material.dart';
import 'package:workapp/admin/create_story.dart';
import 'package:workapp/admin/register_screen.dart';
import 'package:workapp/data/sqldb.dart';

import 'package:workapp/screens/login_screen.dart';

import 'package:workapp/admin/service_screen.dart';

class ListPersons extends StatefulWidget {
  const ListPersons({super.key});

  @override
  State<ListPersons> createState() => _ListPersonsState();
}

class _ListPersonsState extends State<ListPersons> {
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
                      child: Text("إظافة موظف"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("إظافة ستوري"),
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
              FutureBuilder(
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
                                  builder: (context) => ServiceScreen(
                                    title: snapshot.data![index]['first_name'],
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
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
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
                                        fontSize: 24, color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RegisterScreen()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const CreateStory()));
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
