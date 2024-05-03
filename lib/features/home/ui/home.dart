import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keepyoga/features/auth/ui/loginUi.dart';
import 'package:keepyoga/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepyoga/features/yogaLesson/ui/allLessons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 30, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Good Morning",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/S2.png"),
                        ),
                      ),
                      Container(
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: IconButton(
                          onPressed: () {
                            homeBloc.add(HomeLogOutButtonClickedEvent());
                          },
                          icon: const Icon(
                            Icons.power_settings_new,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/images/c1.png"),
                            height: 82,
                            width: 82,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Full Body",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/images/c2.png"),
                            height: 82,
                            width: 82,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Upper Body",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/images/c3.png"),
                            height: 82,
                            width: 82,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lower Body",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage("assets/images/c4.png"),
                            height: 82,
                            width: 82,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Hip And",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                height: 127,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 149, 128, 254),
                        Color.fromARGB(255, 149, 128, 254),
                      ],
                    )),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Basic Yoga",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Top Sessions",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: BlocConsumer<HomeBloc, HomeState>(
                bloc: homeBloc,
                listenWhen: (previous, current) => current is HomeActionState,
                buildWhen: (previous, current) => current is! HomeActionState,
                listener: (BuildContext context, HomeState state) {
                  if (state is HomeYogaSessionSelecttedState) {
                    final successState = state as HomeYogaSessionSelecttedState;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YogaLessons(
                                yogaSessionId: successState.YogaSessionId)));
                  }
                  if (state is HomeLogOutState) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginUi()));
                  }
                  if (state is HometokenExpiredState) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginUi()));
                  }
                },
                builder: (BuildContext context, HomeState state) {
                  switch (state.runtimeType) {
                    case HomeYogaSessionsLoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case HomeYogaSessionsLoadedSuccessState:
                      final successState =
                          state as HomeYogaSessionsLoadedSuccessState;

                      return ListView.builder(
                        itemCount: successState.YogaSession.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              debugPrint(successState.YogaSession[index].lessons
                                  .toString());
                              homeBloc.add(HomeYogaSessionButtonClickedEvent(
                                  clickedYogaSessionId:
                                      successState.YogaSession[index].id));
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
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 75,
                                    width: 75,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the radius as needed
                                      child: Image(
                                        image: NetworkImage(successState
                                            .YogaSession[index].imageUrl),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.error);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          successState.YogaSession[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          "${successState.YogaSession[index].lessons.length} lessons",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          "By ${successState.YogaSession[index].instructor}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      //     body: BlocConsumer<HomeBloc, HomeState>(
      //   bloc: homeBloc,
      //   listenWhen: (previous, current) => current is HomeActionState,
      //   buildWhen: (previous, current) => current is! HomeActionState,
      //   listener: (BuildContext context, HomeState state) {
      //     if (state is HomeYogaSessionSelecttedState) {
      //       final successState = state as HomeYogaSessionSelecttedState;
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   YogaLessons(yogaSessionId: successState.YogaSessionId)));
      //     }
      //   },
      //   builder: (BuildContext context, HomeState state) {
      //     switch (state.runtimeType) {
      //       case HomeYogaSessionsLoadingState:
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       case HomeYogaSessionsLoadedSuccessState:
      //         final successState = state as HomeYogaSessionsLoadedSuccessState;
      //         return Container(
      //           child: ListView.builder(
      //             itemCount: successState.YogaSession.length,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 color: Colors.grey.shade200,
      //                 padding: const EdgeInsets.all(16),
      //                 margin: const EdgeInsets.all(16),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(successState.YogaSession[index].title),
      //                     Text(successState.YogaSession[index].instructor),
      //                     ElevatedButton(
      //                         onPressed: () {
      //                           debugPrint(successState.YogaSession[index].lessons
      //                               .toString());
      //                           homeBloc.add(HomeYogaSessionButtonClickedEvent(
      //                               clickedYogaSessionId:
      //                                   successState.YogaSession[index].id));
      //                         },
      //                         child: Text("Click Me"))
      //                   ],
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       default:
      //         return const SizedBox();
      //     }
      //   },
      // ),
    );
  }
}
