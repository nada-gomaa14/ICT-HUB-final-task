import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_task/authentication/auth_cubit/auth_cubit.dart';
import 'package:final_task/authentication/auth_cubit/auth_cubit_states.dart';
import 'package:final_task/functions/notify.dart';
import 'package:final_task/widgets/profile_widget.dart';
import 'package:final_task/widgets/custom_button_widget.dart';
import 'package:final_task/screens/login_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          notify(context, 'Logout successful');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen()
            )
          );
        }
        if (state is LogoutErrorState) {
          notify(context, "Can't logout, try again");
          log(state.error);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = context.read<AuthCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false
          ),
          body: state is LogoutLoadingState
            ? Center(child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 50,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 120,
                        backgroundImage: NetworkImage('https://img.freepik.com/free-photo/emotive-headshot-portrait-joyful-young-woman_1163-5188.jpg')
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue,
                            )
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ProfileWidget(
                    icon: Icons.person,
                    text: 'Username: ${authCubit.userModel?.username}'
                  ),
                  ProfileWidget(
                    icon: Icons.mail,
                    text: 'Email: ${authCubit.userModel?.email}'
                  ),
                  CustomButtonWidget(
                    text: 'Logout',
                    onTap: () {
                      authCubit.logout();
                    }
                  )
                ],
              ),
            ),
        );
      },
    );
  }
}
