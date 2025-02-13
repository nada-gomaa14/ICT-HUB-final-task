import 'package:flutter/material.dart';


class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'This field is required.';
        }
        else if(!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value) || RegExp(r'\.\.').hasMatch(value) || value.endsWith('.')) {
          return "Incorrect email, make sure it's the right format.";
        }
        else {
          return null;
        }
      },
      controller: emailController,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18
      ),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.blue,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
        hintText: 'Enter your email',
        hintStyle: TextStyle(
          color: Colors.grey
        ),
        prefixIcon: Icon(
          Icons.mail,
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
      keyboardType: TextInputType.emailAddress,
    );
  }
}
