import 'package:flutter/material.dart';
import 'package:keepyoga/features/auth/bloc/auth_bloc.dart';
import 'package:keepyoga/features/auth/ui/loginUi.dart';
import 'package:keepyoga/features/auth/ui/registrationUi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepyoga/features/home/ui/home.dart';

class LaunchUi extends StatefulWidget {
  const LaunchUi({super.key});

  @override
  State<LaunchUi> createState() => _LaunchUiState();
}

class _LaunchUiState extends State<LaunchUi> {
  final AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    authBloc.add(AuthInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (BuildContext context, AuthState state) {
        if (state is AuthSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      },
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 216, 224, 234),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: double.infinity,
                // height: screenSize.height / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 84, 0, 0),
                        child: Text(
                          "keepyoga",
                          style: TextStyle(
                              color: Color.fromARGB(255, 174, 187, 202),
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Practice yoga whenever you want.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: screenSize.height / 1.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/launch.png"),
                    fit: BoxFit.none,
                    alignment: Alignment.center,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(48), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationUi()));
                            },
                            child: const Text(
                              "Get started",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(48), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginUi()));
                            },
                            child: const Text("Log in"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
