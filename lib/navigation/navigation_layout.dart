import 'package:flutter/material.dart';
import 'package:final_task/screens/home_screen.dart';
import 'package:final_task/screens/profile_screen.dart';


class NavigationLayout extends StatefulWidget {
  const NavigationLayout({super.key});

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: screens[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        iconSize: 25,
        selectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile'
          )
        ],
      )
    );
  }
}
