import 'package:flutter/material.dart';
import "package:story_view/story_view.dart";
import 'package:workapp/data/sqldb.dart';

class StoryShow extends StatefulWidget {
  const StoryShow({
    super.key,
  });

  @override
  State<StoryShow> createState() => _StoryShowState();
}

class _StoryShowState extends State<StoryShow> {
  final controller = StoryController();
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM story");
    return response;
  }

  List<StoryItem> listStory = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: readData(),
          builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              for (var i = 0; i < snapshot.data!.length; i++) {
                listStory.add(StoryItem.text(
                  title: snapshot.data![i]['content'],
                  textStyle: const TextStyle(fontSize: 28),
                  backgroundColor: Colors.grey,
                ));
              }
              return StoryView(
                storyItems: listStory,
                controller: controller,
                inline: false,
                repeat: false,
                onComplete: () {
                  Navigator.pop(context);
                },
              );
            }
            return const Center(
              child: Text('لا يوجد ستوريهات'),
            );
          }),
    );
  }
}



// <StoryItem>[
//           StoryItem.text(
//             title: 'test',
//             textStyle: const TextStyle(fontSize: 28),
//             backgroundColor: Colors.grey,
//           ),
//         ]


