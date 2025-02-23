import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/provider/CallProvider.dart';

import 'TimerProvider.dart';

class Fakecallui extends StatefulWidget {
  const Fakecallui({super.key});

  @override
  State<Fakecallui> createState() => _FakecalluiState();
}

class _FakecalluiState extends State<Fakecallui> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CallProvider>(context, listen: false).onThecall(false);
    });
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: mq.height,
        width:  mq.width,
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topCenter, // Start from the top
      end: Alignment.bottomCenter, // End at the bottom
      colors: [
        Color(0xFF122D73), // Top color
        Color(0xFF0CA9C9), // Middle color
        Color(0xFF0E97B6), // Bottom color
      ],
    ),
    ),
        child: Padding(
          padding: EdgeInsets.only(
            top: mq.height*0.1,
            bottom: mq.height*0.08
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 124,
                height: 124,
                decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/images/wmen.png"),
                //     fit: BoxFit.cover,
                // ),
                  shape: BoxShape.circle,
                  color: Colors.white

              ),
                child: Center(
                  child: Icon(
                    Icons.person, // Use the 'man' icon
                    size: 100,  // Adjust icon size as needed
                    color: Colors.black, // Icon color
                  ),
                ),
              ),
              SizedBox(height:mq.height*0.04),
              Text("Papa",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cursive',
                    fontSize: 32,
                    color: Colors.white
                ),
              ),
              SizedBox(height:mq.height*0.015),
              Consumer<CallProvider>(
                  builder: (context, value, child) {
                    return value.oncall ? Consumer<TimerProvider>(
                      builder: (context, timerProvider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Timer Display
                            Container(
                              padding: EdgeInsets.all(12),
                              // decoration: BoxDecoration(
                              //   color: Colors.black,
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: Text(
                                "${timerProvider.hours.toString().padLeft(2, '0')}:"
                                    "${timerProvider.minutes.toString().padLeft(2, '0')}:"
                                    "${timerProvider.seconds.toString().padLeft(2, '0')}",
                                style: TextStyle(fontSize: 24, color: Colors.white),
                              ),
                            ),

                          ],
                        );
                      },
                    )
                    :Text("Incoming Call",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'cursive',
                          fontSize: 32,
                          color: Colors.white
                      ),
                    );

                  },
              ),
              SizedBox(height:mq.height*0.04),

              //
              Consumer<CallProvider>(
                  builder: (context, callProvider, child) {
                    return callProvider.oncall? Container(
                      height: mq.height*0.32,
                      width: mq.width*0.7,
                      // color: Colors.black,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.volume_up,color: Colors.white,size: 40,),
                              Spacer(),
                              Icon(Icons.pause,color: Colors.white,size: 40,),
                              Spacer(),
                              Icon(Ionicons.keypad,color: Colors.white,size: 40,),
                            ],
                          ),
                          SizedBox(height:mq.height*0.06),
                          Row(
                            children: [
                              Icon(Ionicons.videocam,color: Colors.white,size: 40,),
                              Spacer(),
                              Icon(Icons.add_ic_call_sharp,color: Colors.white,size: 40,),
                              Spacer(),
                              Icon(Icons.mic,color: Colors.white,size: 40,),
                            ],
                          ),
                          SizedBox(height:mq.height*0.06),
                          Row(
                            children: [
                              Icon(Icons.change_circle,color: Colors.white,size: 40,),
                              Spacer(),
                              Icon(Icons.merge,color: Colors.white,size: 40,),
                              Spacer(),
                              Icon(Icons.more_horiz,color: Colors.white,size: 40,),
                            ],
                          )
                        ],
                      ),


                    ) : SizedBox(height: mq.height*0.32,);

                  }
              ),
              //
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: mq.width*0.12,right: mq.width*0.12),
                child: Row(
                  children: [
                    Consumer<CallProvider>(
                      builder: (context, value, child) {
                        return value.oncall ? SizedBox() : InkWell(
                          onTap: (){
                            Provider.of<CallProvider>(context, listen: false).onThecall(false);
                            Provider.of<TimerProvider>(context, listen: false).startTimer();

                          },
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.red, // Change color as needed
                              shape: BoxShape.circle, // Makes it a perfect circle
                            ),
                            child: Icon(Icons.call_end,color: Colors.white,size:40,),
                          ),
                        );
                      },
                    ),

                    Spacer(),
                    Consumer<CallProvider>(
                      builder: (context, callProvide, child) {
                        return callProvide.oncall ?
                        InkWell(
                          onTap: (){
                            SystemNavigator.pop();
                          },
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.red, // Change color as needed
                              shape: BoxShape.circle, // Makes it a perfect circle
                            ),
                            child: Icon(Icons.call_end,color: Colors.white,size:40,),
                          ),
                        ) :SizedBox();
                      },

                    ),
                    Spacer(),
                    Consumer<CallProvider>(
                      builder: (context, value, child) {
                        return value.oncall ? SizedBox() : InkWell(
                          onTap: (){
                            Provider.of<CallProvider>(context, listen: false).onThecall(true);

                          },
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.green, // Change color as needed
                              shape: BoxShape.circle, // Makes it a perfect circle
                            ),
                            child: Icon(Icons.call_end,color: Colors.white,size:40,),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    ),
    );


  }
}
