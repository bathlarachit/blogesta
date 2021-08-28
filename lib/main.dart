import 'package:blogesta/blogList.dart';
import 'package:blogesta/favrite.dart';
import 'package:blogesta/read.dart';
import 'package:blogesta/signUp.dart';
import 'package:blogesta/splashScreen.dart';
import 'package:blogesta/write.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => Splash(),
      '/login': (context) => Login(),
      '/SignUp': (context) => SignUp(),
      '/home': (context) => Home(),
      '/read': (context) => ReadPage(),
      '/write': (context) => WriteBlog(),
      "/list": (context) => BlogList(),
      '/fav': (context) => FavList(),
    },
  ));
}
