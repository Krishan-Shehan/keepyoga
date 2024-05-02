import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepyoga/features/yogaLesson/bloc/lesson_bloc.dart';
import 'package:keepyoga/features/yogaSingleLesson/ui/singlelesson.dart';

class YogaLessons extends StatefulWidget {
  final String yogaSessionId;
  const YogaLessons({super.key, required this.yogaSessionId});

  @override
  State<YogaLessons> createState() => _YogaLessonsState();
}

class _YogaLessonsState extends State<YogaLessons> {
  final LessonBloc lessonBloc = LessonBloc();

  @override
  void initState() {
    lessonBloc
        .add(LessonInitialFetchEvent(yogaSessionId: widget.yogaSessionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: BlocConsumer<LessonBloc, LessonState>(
        bloc: lessonBloc,
        listener: (BuildContext context, LessonState state) {
          if (state is LessonYogaSelecttedLesson) {
            final successState = state as LessonYogaSelecttedLesson;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SingleLesson(lessonID: successState.YogaLessonId)));
          }
        },
        builder: (BuildContext context, LessonState state) {
          switch (state.runtimeType) {
            case LessonYogaLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LessonYogaLoadedSuccessState:
              final successState = state as LessonYogaLoadedSuccessState;
              return Container(
                child: Stack(
                  children: [
                    // Text(successState.YogaSession[0].imageUrl),
                    Image(
                        image:
                            NetworkImage(successState.YogaSession[0].imageUrl)),
                    Positioned(
                      left: 18,
                      top: 48,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 24,
                          )),
                    ),
                    Positioned(
                      left: 303,
                      top: 60,
                      child: Container(
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            // return Container(
            //   child: ListView.builder(
            //     itemCount: successState.YogaSession[0].lessons.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         color: Colors.grey.shade200,
            //         padding: const EdgeInsets.all(16),
            //         margin: const EdgeInsets.all(16),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(successState.YogaSession[0].lessons.length
            //                 .toString()),
            //             Text(successState
            //                 .YogaSession[0].lessons[index].title),
            //             Text(successState.YogaSession[0].lessons[index].id),
            //             ElevatedButton(
            //                 onPressed: () {
            //                   debugPrint(successState.YogaSession[0].lessons
            //                       .toString());
            //                   for (var lesson
            //                       in successState.YogaSession[0].lessons) {
            //                     debugPrint(lesson.title);
            //                   }
            //                   lessonBloc.add(LessonYogaButtonClickedEvent(
            //                       clickedYogaLessonId: successState
            //                           .YogaSession[0].lessons[index].id));
            //                 },
            //                 child: Text("Click Me"))
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // );
            default:
              return const SizedBox();
          }
        },
      ),
      // bottomSheet: Container(
      //   height: screenSize.height / 2,
      //   color: Colors.red,
      // ),
    );
  }
}
