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
import 'package:final_task/screens/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if(state is RegisterSuccessState) {
              notify(context, 'Account created successfully');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => NavigationLayout()
                )
              );
            }
            if(state is RegisterErrorState) {
              notify(context, 'Make sure all fields are correct');
              log(state.error);
            }
          },
          builder: (context, state) {
            AuthCubit authCubit = context.read<AuthCubit>();
            return Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 100,
                bottom: 50
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 70,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen()
                          )
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Welcome! Let's create your account!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: state is RegisterLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 20,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'This field is required.';
                                }
                                else {
                                  return null;
                                }
                              },
                              controller: usernameController,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18
                              ),
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                                hintText: 'Enter your username',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 5
                                  )
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 5
                                  )
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            EmailWidget(emailController: emailController),
                            PasswordWidget(
                              label: 'Password',
                              passwordController: passwordController
                            ),
                            PasswordWidget(
                              label: 'Confirm Password',
                              passwordController: confirmController,
                              test: passwordController
                            )
                          ],
                        ),
                    ),
                    CustomButtonWidget(
                      text: 'Register',
                      onTap: (){
                        if(formKey.currentState!.validate()) {
                          authCubit.register(
                            user: {
                              'email' : emailController.text,
                              'password' : passwordController.text,
                              'data' : {'username' : usernameController.text}
                            }
                          );
                        }
                      }
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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}
