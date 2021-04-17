import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/home_screen/components/bottom_navigation_bar.dart';
import 'package:trawus/presentation/screens/profile_screen/profile_screen.dart';

import 'components/home_screen_app_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavigationBarIndexNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeScreenAppBar(),
      body: _bottomNavigationBarIndexNumber == 0? Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
          ],
        ),
      ): ProfileScreenContent(),

      floatingActionButton: searchButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return bottomNavigationBar(
        onTap: _changeBottomNavigationBarIndexNumber,
        selectedIndex: _bottomNavigationBarIndexNumber);
  }

  FloatingActionButton searchButton(){
    return FloatingActionButton(
      child: Icon(Icons.search),
      onPressed: (){},

    );
  }
  void _changeBottomNavigationBarIndexNumber(int index) {
    setState(() {
      _bottomNavigationBarIndexNumber = index;
    });
  }
}// HomeScreenState
