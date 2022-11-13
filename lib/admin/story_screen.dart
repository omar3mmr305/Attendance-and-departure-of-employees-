import 'package:flutter/material.dart';
import "package:story_view/story_view.dart";

class StoryScreen extends StatefulWidget {
  final String content;
  const StoryScreen({
    super.key,
    required this.content,
  });

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoryView(
        storyItems: <StoryItem>[
          StoryItem.text(
            title: widget.content,
            textStyle: const TextStyle(fontSize: 28),
            backgroundColor: Colors.grey,
          ),
        ],
        controller: controller,
        inline: false,
        repeat: false,
        onComplete: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
