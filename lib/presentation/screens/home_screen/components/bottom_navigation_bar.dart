import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigationBar(
    {@required int selectedIndex, @required Function onTap}) {
  return BottomNavigationBar(
    showSelectedLabels: true,
    showUnselectedLabels: false,
    enableFeedback: true,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        backgroundColor: Colors.indigo,
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.indigo,
        icon: Icon(Icons.person_sharp),
        label: 'Profile',
      ),
    ],
    selectedItemColor: Colors.black,
    currentIndex: selectedIndex,
    onTap: onTap,
  );
}
