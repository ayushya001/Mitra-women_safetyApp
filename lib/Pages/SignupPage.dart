import 'package:flutter/material.dart';
import 'package:women_safety/FirebaseServices/SignupFirebase.dart';
import 'package:women_safety/Pages/MobileNumber.dart';
import 'package:women_safety/Pages/VerificationMobileNumber.dart';

import '../Widget/GestureButton.dart';




class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child:Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: mq.width*0.04,right: mq.width*0.04,top: mq.height*0.00),
                      child: Image.asset('assets/images/wmen.png',
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height*0.3,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: mq.width*0.02,right: mq.width*0.02,top: mq.height*0.02),
                        child: Text("SafeSphere",
                          style: TextStyle(
                            fontFamily: 'cursive',
                            fontWeight: FontWeight.bold,
                            fontSize:60,
                          ),),
                      ),
                    ),
                    SizedBox(height: mq.height*0.02,),
                    Gesturebutton(title: 'Signup with Google',imagePath: 'assets/images/glogo.png',
                    onpress: (){
                      SignupFirebase.SigninUsingGoogle(context);
                    },
                    ),
                    SizedBox(height: mq.height*0.025,),
                    Gesturebutton(title: 'Signup with phone',imagePath: 'assets/images/phonelogo.png',
                      onpress: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mobilenumber()),
                        );
                      },
                    ),
                    SizedBox(height: mq.height*0.025,),

                    Padding(
                      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            "Your Safety,Our Commitment",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cursive',
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),

                        ],
                      ),
                    ),


                  ],
                ),
              ),
            )
        ),
    );
  }
}
