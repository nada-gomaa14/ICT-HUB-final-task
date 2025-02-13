import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_task/authentication/auth_cubit/auth_cubit.dart';
import 'package:final_task/authentication/auth_cubit/auth_cubit_states.dart';


class PasswordWidget extends StatefulWidget {
  PasswordWidget({super.key, required this.label, required this.passwordController, this.test});

  final String label;
  final TextEditingController passwordController;
  final String? test;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        AuthCubit authCubit = context.read<AuthCubit>();
        return TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required.';
            }
            else if (value.length < 8) {
              return 'Must be at least 8 characters long.';
            }
            else if(!RegExp(r'[A-Z]').hasMatch(value) || !RegExp(r'[a-z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value)) {
              return 'Must contain uppercase, lowercase letters and digits.';
            }
            else if(value != widget.test && widget.test != null) {
              return 'Make sure both passwords are the same.';
            }
            else {
              return null;
            }
          },
          controller: widget.passwordController,
          obscureText: authCubit.isObscure,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            hintText: 'Enter your password',
            hintStyle: TextStyle(
              color: Colors.grey
            ),
            prefixIcon: Icon(
              Icons.lock,
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
            suffixIcon: IconButton(
              onPressed: () {
                authCubit.changePasswordVisibility();
              },
              icon: authCubit.isObscure
                ? Icon(Icons.visibility, color: Colors.grey)
                : Icon(Icons.visibility_off, color: Colors.grey)
            )
          ),
          keyboardType: TextInputType.visiblePassword,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
