import 'package:flutter/material.dart';
import 'package:workapp/data/sqldb.dart';
import 'package:workapp/admin/story_screen.dart';

class CreateStory extends StatefulWidget {
  const CreateStory({super.key});

  @override
  State<CreateStory> createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM story");
    return response;
  }

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController contentStory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الستوري'),ld
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(workapp-1
            backgroundColor: const Color(0xff2B4865),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('موضوع الستوري'),
                  content: Form(
                      key: formstate,
                      child: TextFormField(
                        controller: contentStory,
                      )),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        int response = await sqlDb.insertData('''
                            INSERT INTO story ("content")
                            VALUES ("${contentStory.text}")
                            ''');
                        print('=======================$response');

                        if (response > 0) {
                          contentStory.clear();
                          setState(() {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: const Text('إظافة'),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 42,
            ),
          ),
          body: FutureBuilder(
            future: readData(),
            builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: 20, bottom: 100),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: ((context, index) {
                      return const Divider(
                        color: Colors.black,
                      );
                    }),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StoryScreen(
                                content: snapshot.data![index]['content'],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: const Text('محتوى الستوري'),
                          subtitle: Text(snapshot.data![index]['content']),
                          leading: Image.asset('images/storie.png'),
                          trailing: IconButton(
                            onPressed: () async {
                              await sqlDb.deleteData(
                                  "DELETE FROM story WHERE id= '${snapshot.data![index]['id']}'");
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFF2B4865),
                              size: 42,
                            ),
                          ),
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
