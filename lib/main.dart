import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/add_new_product_screen.dart';
import 'package:trawus/presentation/screens/create_profile/new_profile_screen.dart';
import 'domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/account_screen/account_screen.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'presentation/screens/home_screen/home_screen.dart';
import 'package:trawus/presentation/screens/profile_screen/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserAuth.isLoggedIn()) {}
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'trawus',
      theme: ThemeData(
        primarySwatch: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserAuth.isLoggedIn() ? HomeScreen() : Account(),
      routes: {
        Account.routeName: (ctx) => Account(),
        NewProfileScreen.routeName: (ctx) => NewProfileScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
        AddNewProductScreen.routeName: (ctx) => AddNewProductScreen(),
      },
    );
  }
}
