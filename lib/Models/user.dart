import 'package:flutter/material.dart';
import 'package:trawus/Models/location_address.dart';

class User {
   String name;
   String email;
   String photoUrl;
   String gender;
   LocationAddress address;

  User({this.name, @required this.email, this.photoUrl, this.gender, this.address});


}