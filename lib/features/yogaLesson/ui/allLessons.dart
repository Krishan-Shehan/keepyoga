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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Text(successState.YogaSession[0].imageUrl),
                      SizedBox(
                        height: screenSize.height / 2,
                        width: double.infinity,
                        child: Image(
                            image: NetworkImage(
                                successState.YogaSession[0].imageUrl),
                            fit: BoxFit.cover),
                      ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            successState.YogaSession[0].title,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 24.0),
                          ),
                        ),
                        // child: Text(
                        //   successState.YogaSession[0].title,
                        //   style: TextStyle(
                        //       fontSize: 24, fontWeight: FontWeight.w700),
                        // ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "${successState.YogaSession[0].lessons.length} Lessons",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 106, 77, 254)),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: successState.YogaSession[0].lessons.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            lessonBloc.add(LessonYogaButtonClickedEvent(
                                clickedYogaLessonId: successState
                                    .YogaSession[0].lessons[index].id));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.content_paste_search_outlined,
                                      size: 32,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(successState
                                        .YogaSession[0].lessons[index].title),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        successState.YogaSession[0]
                                            .lessons[index].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0),
                                      ),
                                    ),
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.play_circle,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
