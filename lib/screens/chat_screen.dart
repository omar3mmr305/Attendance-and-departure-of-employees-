import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart' as intl;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;
  late String submittedMessage;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('شات'),
          ),
          body: Column(
            children: [
              Expanded(
                child: GroupedListView<Message, DateTime>(
                  padding: const EdgeInsets.all(8),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  elements: messages,
                  groupBy: (message) => DateTime(
                    message.date.year,
                    message.date.month,
                    message.date.day,
                  ),
                  groupHeaderBuilder: (Message message) => SizedBox(
                    height: 40,
                    child: Center(
                      child: Card(
                        color: const Color(0xff2B4865),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            intl.DateFormat.yMMMd().format(message.date),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemBuilder: (context, Message message) => Align(
                    alignment: message.isSendByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Bubble(
                      color: message.isSendByMe
                          ? const Color(0xFF256D85)
                          : Colors.white,
                      margin: const BubbleEdges.only(top: 10),
                      nip: message.isSendByMe
                          ? BubbleNip.rightTop
                          : BubbleNip.leftTop,
                      child: Text(
                        message.text,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: const Color(0xFF002B5B),
                width: MediaQuery.of(context).size.width,
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77,
                      height: 50,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(12),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'ادخل رسالتك ...',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none)),
                        onChanged: (text) {
                          submittedMessage = text;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          messages.add(Message(
                            text: submittedMessage,
                            date: DateTime.now(),
                            isSendByMe: false,
                          ));
                        });
                        _controller.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSendByMe;

  const Message({
    required this.text,
    required this.date,
    required this.isSendByMe,
  });
}
