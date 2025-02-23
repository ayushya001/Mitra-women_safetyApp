import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/Pages/HomePage.dart';
import 'package:women_safety/Pages/ProfileDeatails.dart';
import 'package:women_safety/provider/SignupProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupFirebase{
  final currentUser = FirebaseAuth.instance.currentUser;
  static final auth = FirebaseAuth.instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static SigninUsingGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled the sign-in

      // Obtain the auth details from the Google user
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      // Sign in to Firebase
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final String? userEmail = userCredential.user?.email;

      if (userEmail != null) {
        // Save email in local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', userEmail);
        print("Email saved locally: $userEmail");
      }

      // Check if the user was successfully signed in
      if (userCredential.user != null) {
        // Check if the user's document exists in the "Users" collection
        FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).get().then((documentSnapshot){
          if (documentSnapshot.exists) {
            print("profile details is already present in firestore");
            // If the document exists, navigate to the Homepage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          } else {
            // If the document does not exist, navigate to the ProfileDetails page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileDetails(),
              ),
            );
          }
          Provider.of<Signupprovider>(context, listen: false).setloading(false);

        }).catchError((error) {
          // Handle any errors that might occur
          print("Error checking user document: $error");
        });



      }
    }  catch (e) {
      print("Error signing in with Google: $e");
      Provider.of<Signupprovider>(context, listen: false).setloading(false);
      return null;
    }
  }

  static SigninUsingOtp(BuildContext context,String verificationId,String otpController)  async {

    try {
      final cred = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otpController);

      await FirebaseAuth.instance.signInWithCredential(cred);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetails()
          ));
    } catch (e) {

    }

  }

}