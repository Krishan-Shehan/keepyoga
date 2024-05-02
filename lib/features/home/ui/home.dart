import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: Text("ggg"),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
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
                return Container(
                  child: ListView.builder(
                    itemCount: successState.YogaSession.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(successState.YogaSession[index].title),
                            Text(successState.YogaSession[index].instructor),
                            ElevatedButton(
                                onPressed: () {
                                  debugPrint(successState
                                      .YogaSession[index].lessons
                                      .toString());
                                  homeBloc.add(
                                      HomeYogaSessionButtonClickedEvent(
                                          clickedYogaSessionId: successState
                                              .YogaSession[index].id));
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
