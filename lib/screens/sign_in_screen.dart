import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpaper_app/config/config.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;             // database name db

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
         children: [
           Image(
             image: AssetImage("assets/bg.jpg"),
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             fit: BoxFit.cover,
           ),

           Container(
             //alignment: Alignment.center,
             width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.only(top: 100),
             child: Image(
               image: AssetImage('assets/logo_circle.png'),
               height: 200,
               width: 200,
             ),
           ),

           Positioned(
             bottom: 40,
             left: 0,
             right: 0,
             child: Container(
               margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
               width: MediaQuery.of(context).size.width,
               child: InkWell(
                 onTap: _signIn,
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(32.0),
                       gradient: LinearGradient(
                         colors: [
                           primaryColor,
                           secondaryColor,
                         ],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       )
                   ),
                   child: Text(
                     "Google Sign In",style: TextStyle(fontSize: 20),
                     textAlign: TextAlign.center,
                   ),
                 ),
               ),
             ),
           )

         ],
        ),
      ),
    );
  }

  void _signIn()async{
   try{
     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

     final AuthCredential credential = GoogleAuthProvider.getCredential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );
     final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
     print("signed in " + user.displayName);

     _db.collection("users").document(user.uid).setData({                 //create user details on database
       "displayName" :user.displayName,
       "email":user.email,
       "uId":user.uid,
       "photoUrl":user.photoUrl,
       "lastSignIn":DateTime.now(),
     });
   }catch(e){
     print(e.message);
   }
  }

}
