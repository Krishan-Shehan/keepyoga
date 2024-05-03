import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepyoga/features/auth/bloc/auth_bloc.dart';
import 'package:keepyoga/features/auth/ui/loginUi.dart';
import 'package:keepyoga/features/home/ui/home.dart';

class RegistrationUi extends StatefulWidget {
  const RegistrationUi({Key? key}) : super(key: key);

  @override
  State<RegistrationUi> createState() => _RegistrationUiState();
}

class _RegistrationUiState extends State<RegistrationUi> {
  final AuthBloc authBloc = AuthBloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is RegistrationSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginUi()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case RegistrationLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: screenSize.height - 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 64,
                                  ),
                                  const Text(
                                    "Registration",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Create your account",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      labelText: 'Email',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      labelText: 'username',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: genderController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      labelText: 'gender',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      labelText: 'password',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
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
                                authBloc.add(RegistrationButtonPressedEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    gender: genderController.text,
                                    username: usernameController.text));
                              },
                              child: const Text("Register"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
