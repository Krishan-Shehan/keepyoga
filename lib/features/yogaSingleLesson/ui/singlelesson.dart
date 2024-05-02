import 'package:flutter/material.dart';
import 'package:keepyoga/features/yogaSingleLesson/bloc/single_lesson_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleLesson extends StatefulWidget {
  final String lessonID;
  const SingleLesson({super.key, required this.lessonID});

  @override
  State<SingleLesson> createState() => _SingleLessonState();
}

class _SingleLessonState extends State<SingleLesson> {
  final SingleLessonBloc singleLessonBloc = SingleLessonBloc();

  @override
  void initState() {
    singleLessonBloc
        .add(SingleLessonInitialFetchEvent(yogaLessonId: widget.lessonID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("S less")),
        body: BlocConsumer<SingleLessonBloc, SingleLessonState>(
          bloc: singleLessonBloc,
          listener: (BuildContext context, SingleLessonState state) {},
          builder: (BuildContext context, SingleLessonState state) {
            switch (state.runtimeType) {
              case SingleLessonYogaLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SingleLessonYogaLoadedSuccessState:
                final successState =
                    state as SingleLessonYogaLoadedSuccessState;
                return Container(
                  child: ListView.builder(
                    itemCount: successState.YogaLesson.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(successState.YogaLesson[0].id.toString()),
                            Text(successState.YogaLesson[0].title),
                            Text(successState.YogaLesson[0].videoUrl),
                            ElevatedButton(
                                onPressed: () {
                                  debugPrint(
                                      successState.YogaLesson[0].toString());
                                },
                                child: Text("Click Me"))
                          ],
                        ),
                      );
                    },
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ));
  }
}
