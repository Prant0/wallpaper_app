import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/config/config.dart';
import 'package:wallpaper_app/screens/home_page_screen.dart';
import 'package:wallpaper_app/screens/sign_in_screen.dart';

void main(){
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,


      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(         //event change hoila streamBuilder   ,, SharedPreferance
      stream:_auth.onAuthStateChanged,
      builder: (ctx, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.hasData){
          FirebaseUser user=snapshot.data;
          if(user!=null){
            return HomePageScreen();
          }else {
            return SignInScreen();
          }
        }
        return SignInScreen();
      },
    );
  }
}


