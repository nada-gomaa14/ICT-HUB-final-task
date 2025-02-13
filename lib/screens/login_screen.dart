import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_task/authentication/auth_cubit/auth_cubit.dart';
import 'package:final_task/authentication/auth_cubit/auth_cubit_states.dart';
import 'package:final_task/functions/notify.dart';
import 'package:final_task/widgets/email_widget.dart';
import 'package:final_task/widgets/password_widget.dart';
import 'package:final_task/widgets/custom_button_widget.dart';
import 'package:final_task/navigation/navigation_layout.dart';
import 'package:final_task/screens/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              notify(context, 'Login successful');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => NavigationLayout()
                )
              );
            }
            if (state is LoginErrorState) {
              notify(context, 'Make sure you have an account.');
              log(state.error);
            }
          },
          builder: (context, state) {
            AuthCubit authCubit = context.read<AuthCubit>();
            return Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 200,
                bottom: 50
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 100,
                  children: [
                    Text(
                      'Welcome back! Glad to see you, Again!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: state is LoginLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 20,
                          children: [
                            EmailWidget(emailController: emailController),
                            PasswordWidget(label: 'Password', passwordController: passwordController)
                            ],
                        )
                    ),
                    CustomButtonWidget(
                      text: "Login",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          authCubit.login(
                            user: {
                              'email': emailController.text,
                              'password': passwordController.text,
                            }
                          );
                        }
                      }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen()
                              )
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
