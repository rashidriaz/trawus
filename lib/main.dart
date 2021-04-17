import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/presentation/screens/account_screen/account_screen.dart';
import 'file:///D:/Flutter/trawus/lib/presentation/screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'trawus',
      theme: ThemeData(
        primarySwatch: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        Account.routeName: (ctx) => Account(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
