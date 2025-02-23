import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Nointernetpage extends StatefulWidget {
  const Nointernetpage({super.key});

  @override
  State<Nointernetpage> createState() => _NointernetpageState();
}

class _NointernetpageState extends State<Nointernetpage> {

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
        body:SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: mq.width*0.04,right: mq.width*0.04,top: mq.height*0.15),
                  child: Image.asset('assets/images/no_internet.png',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height*0.5,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: mq.width*0.01,right: mq.width*0.01,top: mq.height*0.04),
                  child: Text("Oops! No Internet",
                    style: TextStyle(
                      fontFamily: 'cursive',
                      fontWeight: FontWeight.bold,
                      fontSize:44,
                    ),),
                ),
              ),

            ],
          ),
        )



    );
  }
}
