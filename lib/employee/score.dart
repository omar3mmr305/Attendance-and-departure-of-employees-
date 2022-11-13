import 'package:flutter/material.dart';
import '../data/sqldb.dart';

class Score extends StatefulWidget {
  const Score({super.key});

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readDBAccess() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'access'");

    return response;
  }

  Future<List<Map>> readDBExit() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'exit'");

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('حظور و انصراف'),
            ),
            body: PageView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FutureBuilder(
                      future: readDBAccess(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map>> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Text(
                                  'الدخول',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Colors.black,
                                      )),
                                      child: Text(
                                        snapshot.data![index]['access'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    );
                                  }),
                            ],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FutureBuilder(
                      future: readDBExit(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map>> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Text(
                                  'الخروج',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Colors.black,
                                      )),
                                      child: Text(
                                        snapshot.data![index]['exit'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    );
                                  }),
                            ],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
