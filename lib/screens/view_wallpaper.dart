import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WallPagerScreen extends StatefulWidget {
  final String image;
  WallPagerScreen({this.image});

  @override
  _WallPagerScreenState createState() => _WallPagerScreenState();
}

class _WallPagerScreenState extends State<WallPagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: Hero(
                  tag: widget.image,
                    child:CachedNetworkImage(
                      placeholder: (context, index)=>Image(image: AssetImage("assets/ph.png"),),
                      imageUrl: widget.image,
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
