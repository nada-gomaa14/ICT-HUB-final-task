import 'package:final_task/authentication/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_task/core/observer.dart';
import 'package:final_task/screens/login_screen.dart';


void main() {
  Bloc.observer = MyObserver();
  runApp(Task3());
}

class Task3 extends StatelessWidget {
  const Task3({super.key});

  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}