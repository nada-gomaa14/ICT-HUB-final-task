import 'package:flutter/material.dart';
import 'package:final_task/screens/home_screen.dart';


class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({super.key, required this.text, required this.onTap});

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue
        ),
        height: 60,
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
