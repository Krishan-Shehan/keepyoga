import 'package:flutter/material.dart';
import 'package:keepyoga/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepyoga/features/home/ui/home.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    // authBloc.add(AuthInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
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
                return Column(
                  children: [
                    Text("name"),
                    TextField(),
                    Text("password"),
                    TextField(),
                    ElevatedButton(
                        onPressed: () {
                          authBloc.add(LoginButtonPressedEvent(
                              email: "email", password: "password"));
                        },
                        child: Text("Login"))
                  ],
                );
            }
            return Container();
          },
        ));
  }
}
