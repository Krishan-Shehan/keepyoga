import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepyoga/features/auth/bloc/auth_bloc.dart';
import 'package:keepyoga/features/home/ui/home.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final AuthBloc authBloc = AuthBloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          if (state is LoginSuccessState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView(
                children: [
                  Container(
                    height: screenSize.height / 2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/S2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'Email',
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'password',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Implement your forgot password functionality here
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF6B4EFF),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            children: [
                              const TextSpan(
                                text: "By continuing, you agree to our ",
                              ),
                              TextSpan(
                                text: "Terms of Service ",
                                style: TextStyle(color: Color(0xFF6B4EFF)),
                              ),
                              const TextSpan(
                                text: "and ",
                              ),
                              TextSpan(
                                text: "Privacy Policy.",
                                style: TextStyle(color: Color(0xFF6B4EFF)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                                authBloc.add(LoginButtonPressedEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              },
                              child: const Text("Login"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
