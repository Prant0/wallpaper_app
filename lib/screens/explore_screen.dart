import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/screens/view_wallpaper.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var _images =[
    "https://images.unsplash.com/photo-1602696221981-75511960e2b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602711106125-ba107f6c4ecc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602718689734-c85e919169fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602605323163-62ce11f5c85e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602526431715-81a7851b96d8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602697914293-e12bc6cc8253?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1602696048938-168a3ff6c498?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 18,left: 20),
              child: Text("Explorer",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700,color: Colors.white54),),
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
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WallPagerScreen(image: _images[index],)));
                  },
                  child: Hero(
                    tag: _images[index],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      /*child: Image(
                        image: NetworkImage(_images[index]),
                      ),*/

                      child:CachedNetworkImage(
                        placeholder: (context, index)=>Image(image: AssetImage("assets/ph.png"),),
                        imageUrl: _images[index],
                      )
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
