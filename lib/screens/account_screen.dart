import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/screens/add_wallPaper_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var _images =[
    "https://images.unsplash.com/photo-1602696221981-75511960e2b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602711106125-ba107f6c4ecc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602718689734-c85e919169fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602605323163-62ce11f5c85e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602526431715-81a7851b96d8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602697914293-e12bc6cc8253?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602696048938-168a3ff6c498?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
  ];


  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    FirebaseUser u = await _auth.currentUser();
    setState(() {
      _user = u;
    });
  }
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: _user != null ?Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: FadeInImage(
                  width: 200.0,
                  height: 200.0,
                  image: NetworkImage(
                    "${_user.photoUrl}",
                  ),
                  placeholder: AssetImage('assets/ph.png'),
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "${_user.displayName}",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),

            RaisedButton(
              onPressed: (){
                _auth.signOut();
              },

              child: Text("LogOut"),
            ),

            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("WallPaper",style: TextStyle(fontSize: 18),),

                  IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddWallpaperScreen(),fullscreenDialog: true));

                    },
                    icon: Icon(Icons.add,size: 35,color: Colors.tealAccent,),
                  )
                ],
              ),
            ),

        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 18,left: 20),
                  child: Text("Favourite",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700,color: Colors.white54),),
                ),
                StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  staggeredTileBuilder: (int index)=> StaggeredTile.fit(1),
                  itemCount: _images.length,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemBuilder: (context,index){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image(
                        image: NetworkImage(_images[index]),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
          ],
        ) : LinearProgressIndicator(

        ),
      ),
    );
  }
}
