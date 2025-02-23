import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety/Pages/SignupPage.dart';
import 'package:women_safety/Pages/VerificationMobileNumber.dart';
import 'package:women_safety/provider/Signup_mobile.dart';

import '../Utils/general_utils.dart';
import '../provider/SignupProvider.dart';

class Mobilenumber extends StatefulWidget {
  const Mobilenumber({super.key});

  @override
  State<Mobilenumber> createState() => _MobilenumberState();
}

class _MobilenumberState extends State<Mobilenumber> {
  final phoneController = TextEditingController();

  bool isloading = false;
  var _otp = "";

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.all(8.0), // Optional padding
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Icon(Icons.arrow_back_ios,
                      size: 16,),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F7FF), // Set color
                    shape: BoxShape.circle, // Makes it circular
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Padding(
                padding: EdgeInsets.only(top: mq.height * 0.02),
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: mq.width * 0.8,
                      child: Text("Please Enter Your Mobile Number",
                        style: TextStyle(
                          // fontFamily: 'cursive',
                          // fontWeight: FontWeight.bold,
                            fontSize: mq.width * 0.05
                        ),
                      ),
                    )
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: mq.width * 0.8,
                    child: Text(
                      "We will send a otp to your Mobile Number, please verify the code.",
                      style: TextStyle(
                          color: Color(0xFF6C6F72)

                      ),
                    ),
                  )
              ),
              SizedBox(height: mq.height * 0.06,),
              Container(
                // height: 100,
                width: mq.width * 0.8,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Mobile Numer",
                          style: TextStyle(fontSize: mq.width * 0.05),)),
                    SizedBox(height: mq.height * 0.015,),
                    Container(
                      height: mq.height * 0.06,
                      width: mq.width * 08,
                      // color: Colors.black,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Black border color
                          width: 1.0, // Border width of 1
                        ),
                        borderRadius: BorderRadius.circular(
                            5), // Border radius of 5
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: mq.height * 0.07,
                            child: Padding(
                              padding: EdgeInsets.only(left: mq.width * 0.035),
                              child: Text(
                                "+91",
                                style: TextStyle(
                                  fontSize: 18,
                                ),

                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: mq.width * 0.05,
                                  right: mq.width * 0.05),
                              child: TextField(
                                controller: phoneController,
                                style: TextStyle(fontSize: 18),
                                keyboardType: TextInputType.number,
                                // Allows only numeric input
                                decoration: InputDecoration(
                                  hintText: "Enter Your Mobile Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,

                                ),
                              ),
                            ),
                          )
                        ],

                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.only(top: mq.height * 0.04),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Get the phone number text
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('Mobile_no', phoneController.text.trim());
                          Provider.of<SignupMobile>(context, listen: false).setloading(true);
                          String phoneNumber = phoneController.text.trim();

                          if (phoneNumber.isEmpty || phoneNumber.length != 10) {
                            Utils.flushBarErrorMessage(
                                "Enter Your 10 Digit Mobile Number", context);
                            Provider.of<SignupMobile>(context, listen: false).setloading(false);
                            return; // Stop execution if the number is invalid
                          }

                          try {

                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: "+91"+phoneController.text,
                              verificationCompleted: (phoneAuthCredential) {},
                              verificationFailed: (error) {
                                Provider.of<SignupMobile>(context, listen: false).setloading(false);

                                print(error.toString());
                              },
                              codeSent: (verificationId, forceResendingToken) {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MobileVerification(
                                              VerificationId: verificationId,
                                        )));
                                Provider.of<SignupMobile>(context, listen: false).setloading(false);

                              },
                              codeAutoRetrievalTimeout: (verificationId) {
                                print("Auto Retireval timeout");
                                Provider.of<SignupMobile>(context, listen: false).setloading(false);

                              },
                            );
                          } catch (e) {
                            print("Error verifying phone number: $e");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width * 0.8,
                                MediaQuery.of(context).size.height * 0.06),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Consumer<SignupMobile>(
                          builder: (context, signupProvider, child) {
                            return signupProvider.loading
                                ? Center(
                              child: CircularProgressIndicator(backgroundColor: Colors.white),
                            )
                                : Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: mq.height * 0.04),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              text: "Want different Signup option? ",
                              style: TextStyle(color: Color(0xFF6C6F72),),
                              children: [
                                TextSpan(
                                  text: "Another option",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    // Blue color for "Resend"
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration
                                        .underline, // Optional underline
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signuppage()),
                                      ); // Replace this with your function
                                    },
                                ),
                              ],
                            ),
                          )
                      ),
                    )
                  ],
                ),

              )


            ],
          )
      ),
    );
  }
}
