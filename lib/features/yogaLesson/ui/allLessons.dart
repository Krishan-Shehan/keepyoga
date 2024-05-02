import 'package:flutter/material.dart';

class YogaLessons extends StatefulWidget {
  final String yogaSessionId;
  const YogaLessons({super.key, required this.yogaSessionId});

  @override
  State<YogaLessons> createState() => _YogaLessonsState();
}

class _YogaLessonsState extends State<YogaLessons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Center(
        child: Text("Yoga Lessons ${widget.yogaSessionId}"),
      ),
    );
  }
}
