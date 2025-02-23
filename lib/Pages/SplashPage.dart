import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/Pages/HomePage.dart';
import 'package:women_safety/Pages/SignupPage.dart';

import 'ProfileDeatails.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      // After 5 seconds, check authentication
      _checkAuthantication(context);
    });
  }




  @override
  Widget build(BuildContext context) {

    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: mq.width*0.04,right: mq.width*0.04,top: mq.height*0.08),
              child: Image.asset('assets/images/wmen.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height*0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: mq.width*0.04,right: mq.width*0.04,top: mq.height*0.08),
              child: Text("Women Safety ",
              style: TextStyle(
                fontFamily: 'cursive',
                fontWeight: FontWeight.bold,
                fontSize:54,
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(left: mq.width*0.04,right: mq.width*0.04,top: mq.height*0.03),
              child: Image.asset('assets/images/wlogo.png',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height*0.06,
              ),
            ),
          ],
        ),
      )



    );
  }
  void _checkAuthantication(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;


    if (user == null) {
      print("User is null");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Signuppage()),
            (Route<dynamic> route) => false, // This removes all previous routes from the stack
      );

    } else {

      //
      FirebaseFirestore.instance.collection('Users').doc(user.uid).get().then((documentSnapshot) {
        if (documentSnapshot.exists) {
          print("profile details is already present in firestore");
          // If the document exists, navigate to the Homepage
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Homepage()),
                (Route<dynamic> route) => false, // This removes all previous routes from the stack
          );
        } else {
          // If the document does not exist, navigate to the ProfileDetails page
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ProfileDetails()),
                (Route<
                dynamic> route) => false, // This removes all previous routes from the stack
          );
        }
      });





      //else ka } nicche hai
    }

  }
}
