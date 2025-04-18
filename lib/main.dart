import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/Features/FakeCallUi.dart';
import 'package:women_safety/Pages/HomePage.dart';
import 'package:women_safety/Pages/MobileNumber.dart';
import 'package:women_safety/Pages/Nointernet.dart';
import 'package:women_safety/Pages/ProfileDeatails.dart';
import 'package:women_safety/Pages/SignupPage.dart';
import 'package:women_safety/Pages/SplashPage.dart';
import 'package:women_safety/Pages/VerificationMobileNumber.dart';
import 'package:women_safety/provider/AddProvider.dart';
import 'package:women_safety/provider/CallProvider.dart';
import 'package:women_safety/provider/SearchProvider.dart';
import 'package:women_safety/provider/SignupProvider.dart';
import 'package:women_safety/provider/Signup_mobile.dart';
import 'package:women_safety/provider/SosButtonProvider.dart';
import 'package:women_safety/provider/circularPrgsbar.dart';

import 'Features/TimerProvider.dart';
import 'Pages/Details.dart';
import 'Utils/AddContactProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initializeFCM();
  // Set the background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle the background message
  print("Handling a background message: ${message.messageId}");
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => circularprgsbar()),
        ChangeNotifierProvider(create: (_) => CallProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => Signupprovider()),
        ChangeNotifierProvider(create: (_) => SignupMobile()),
        ChangeNotifierProvider(create: (_) => SosButtonProvider()),
        ChangeNotifierProvider(create: (_) => ContactButtonProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => AddProvider()),


        // ChangeNotifierProvider(create: (_) =>  ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // set to false to remove debug banner
        routes: {
          '/':(context)=> SplashPage()
        },
      ),

    );
  }

}



