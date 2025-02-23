import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety/Pages/ProfileDeatails.dart';

import '../Utils/general_utils.dart';
import '../provider/SignupProvider.dart';
import '../provider/Signup_mobile.dart';

class MobileVerification extends StatefulWidget {
  final String VerificationId;
  const MobileVerification({super.key, required this.VerificationId});

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  var _otp = "";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 48,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(5),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.all(8.0), // Optional padding
              child: Container(
                height: 40,
                width: 40,
                child: Center(
                  child: Icon(Icons.arrow_back_ios,
                    size: 16,),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F7FF), // Set color
                  shape: BoxShape.circle,   // Makes it circular
                ),
              ),
            ),
          ),
          body:Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Padding(
                padding: EdgeInsets.only(top: mq.height*0.02),
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: mq.width*0.8,
                      child: Text("Please Verify Your Mobile Number",
                        style: TextStyle(
                          // fontFamily: 'cursive',
                          // fontWeight: FontWeight.bold,
                            fontSize: mq.width*0.05
                        ),
                      ),
                    )
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: mq.width*0.8,
                    child: Text("We’ve sent an email to becca@gmail.com, please enter the code below.",
                      style: TextStyle(
                          color:  Color(0xFF6C6F72)

                      ),
                    ),
                  )
              ),
              SizedBox(height: mq.height*0.06,),
              Container(
                // height: 100,
                width: mq.width*0.8,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Code",style: TextStyle(fontSize: mq.width*0.05),)),
                    SizedBox(height: mq.height*0.01,),
                    Pinput(
                      length: 6,
                      // defaultPinTheme: defaultPinTheme,
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,

                      showCursor: true,
                      onCompleted: (pin) => _otp=pin,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: List.generate(6, (index) {
                    //     return Container(
                    //       height: 44,
                    //       width: 48,
                    //       child: RawKeyboardListener(
                    //         focusNode: FocusNode(),
                    //         onKey: (event) => _handleKeyEvent(event, index),
                    //         child: TextField(
                    //           controller: controllers[index],
                    //           focusNode: focusNodes[index],
                    //           textAlign: TextAlign.center,
                    //           keyboardType: TextInputType.number,
                    //           maxLength: 1,
                    //           onChanged: (value) => _handleTextChange(value, index),
                    //           decoration: InputDecoration(
                    //             counterText: "",
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(5),
                    //               borderSide: BorderSide(color: Color(0xFFCBD2E0)),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   }),
                    // ),
                    Padding(
                      padding:  EdgeInsets.only(top: mq.height*0.04),
                      child: ElevatedButton(
                        onPressed: () async {

                          // onpress();
                          Provider.of<SignupMobile>(context, listen: false).setloading2(true);
                          if(_otp.length!=6){
                            Utils.flushBarErrorMessage("Enter the complete otp",context);
                            Provider.of<SignupMobile>(context, listen: false).setloading(false);
                          }else{

                            try {
                              final cred = PhoneAuthProvider.credential(
                                  verificationId: widget.VerificationId,
                                  smsCode: _otp);

                              await FirebaseAuth.instance.signInWithCredential(cred);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileDetails(),
                                  ));
                              Provider.of<SignupMobile>(context, listen: false).setloading(false);
                            } catch (e) {
                              Provider.of<SignupMobile>(context, listen: false).setloading(false);
                              print("The error is:-"+e.toString());
                            }



                          }

                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                          fixedSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.06)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Set the circular border radius here
                            ),
                          ),
                        ),
                        child: Consumer<Signupprovider>(
                            builder: (context, signupProvider, child) {
                              return signupProvider.loading
                                  ? Center(
                                  child: CircularProgressIndicator(backgroundColor: Colors.white))
                                  : Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                              );
                            }
                        ),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mq.height*0.04),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              text: "Didn’t see your email? ",
                              style: TextStyle(color:Color(0xFF6C6F72),),
                              children: [
                                TextSpan(
                                  text: "Resend",
                                  style: TextStyle(
                                    color: Colors.blue, // Blue color for "Resend"
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline, // Optional underline
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("Resend clicked!"); // Replace this with your function
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

