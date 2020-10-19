import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/account_screen.dart';
import 'package:wallpaper_app/screens/explore_screen.dart';
import 'package:wallpaper_app/screens/favourite_screen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  int _selectPageIndex = 0;
  var _pages =[
    ExploreScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search,),
            title: Text("Explore",style: TextStyle(),)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border,),
              title: Text("Favourites",style: TextStyle(),)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,),
              title: Text("Accounts",style: TextStyle(),)
          )
        ],
        currentIndex: _selectPageIndex,
        onTap: (index){
          setState(() {
            _selectPageIndex=index;
          });
        },
      ),
      body: _pages[_selectPageIndex],
    );
  }
}
