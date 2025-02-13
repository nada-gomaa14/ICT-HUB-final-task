import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.black,
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20
            ),
          ),
        ],
      ),
    );
  }
}
