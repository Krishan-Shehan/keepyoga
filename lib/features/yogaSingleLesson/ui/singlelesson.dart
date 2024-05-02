import 'package:flutter/material.dart';
import 'package:keepyoga/features/yogaLesson/ui/allLessons.dart';
import 'package:keepyoga/features/yogaSingleLesson/bloc/single_lesson_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class SingleLesson extends StatefulWidget {
  final String lessonID;
  const SingleLesson({super.key, required this.lessonID});

  @override
  State<SingleLesson> createState() => _SingleLessonState();
}

class _SingleLessonState extends State<SingleLesson> {
  final SingleLessonBloc singleLessonBloc = SingleLessonBloc();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    singleLessonBloc
        .add(SingleLessonInitialFetchEvent(yogaLessonId: widget.lessonID));
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        "",
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<SingleLessonBloc, SingleLessonState>(
        bloc: singleLessonBloc,
        listenWhen: (previous, current) => current is SingleLessonActionState,
        listener: (BuildContext context, SingleLessonState state) {
          if (state is SingleLessonYogaSelectedSession) {
            final successState = state as SingleLessonYogaSelectedSession;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => YogaLessons(
                        yogaSessionId: successState.YogaSessionId)));
          }
        },
        builder: (BuildContext context, SingleLessonState state) {
          switch (state.runtimeType) {
            case SingleLessonYogaLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SingleLessonYogaLoadedSuccessState:
              final successState = state as SingleLessonYogaLoadedSuccessState;
              _controller = VideoPlayerController.networkUrl(
                Uri.parse(
                  successState.YogaLesson[0].videoUrl,
                ),
              );
              _initializeVideoPlayerFuture = _controller.initialize();
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: screenSize.height / 1.3,
                          child: FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        Positioned(
                          left: 18,
                          top: 48,
                          child: IconButton(
                              onPressed: () {
                                singleLessonBloc.add(
                                    SingleLessonYogaBackButtonClickedEvent(
                                        clickedYogaSessionId: successState
                                            .YogaLesson[0].sessionId));
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
                                singleLessonBloc.add(
                                    SingleLessonYogaBackButtonClickedEvent(
                                        clickedYogaSessionId: successState
                                            .YogaLesson[0].sessionId));
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          child: Container(
                            width: screenSize.width,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Text(
                                    successState.YogaLesson[0].title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Text(
                                    successState.YogaLesson[0].description,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(16),
                              ),
                              child: Icon(
                                Icons.skip_previous,
                                size: 24,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller.play();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(24),
                              ),
                              child: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 32,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(16),
                              ),
                              child: Icon(
                                Icons.skip_next,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
