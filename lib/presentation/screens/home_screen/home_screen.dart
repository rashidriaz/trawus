import 'package:flutter/material.dart';
import 'package:trawus/components/nothing_to_show_screen.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/add_new_product_screen.dart';
import 'package:trawus/presentation/screens/home_screen/components/bottom_navigation_bar.dart';
import 'package:trawus/presentation/screens/home_screen/components/home_screen_app_bar.dart';
import 'package:trawus/presentation/screens/profile_screen/profile_screen.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  bool firstTime = true;

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavigationBarIndexNumber = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.firstTime) {
      widget.firstTime = false;
      bool goToTheProfileScreen =
          ModalRoute.of(context).settings.arguments as bool ?? false;
      if (goToTheProfileScreen) {
        _bottomNavigationBarIndexNumber = 1;
      }
    }
    return Scaffold(
      appBar: homeScreenAppBar(
          context: context, index: _bottomNavigationBarIndexNumber),
      body: _bottomNavigationBarIndexNumber == 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: nothingToShowOnScreen(),
            )
          : ProfileScreen(),
      floatingActionButton:
          _bottomNavigationBarIndexNumber == 0 ? addButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return bottomNavigationBar(
        onTap: _changeBottomNavigationBarIndexNumber,
        selectedIndex: _bottomNavigationBarIndexNumber);
  }

  FloatingActionButton addButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(AddNewProductScreen.routeName);
      },
    );
  }

  void _changeBottomNavigationBarIndexNumber(int index) {
    setState(() {
      _bottomNavigationBarIndexNumber = index;
    });
  }
} // HomeScreenState
