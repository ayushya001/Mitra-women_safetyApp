import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:women_safety/Features/FakeCallUi.dart';
import 'package:women_safety/Features/NearBySafespots.dart';
import 'package:women_safety/Features/SafetyTips.dart';

class Features extends StatelessWidget {

  final String title;
  final VoidCallback onpress;
  final Icon icon ;
  final int id;
  const Features({super.key, required this.title, required this.onpress, required this.icon,required this.id});

  @override
  Widget build(BuildContext context) {


    final mq = MediaQuery.of(context).size;
    return
      GestureDetector(
        onTap:(){
          if(id==1){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Nearbysafespots()),
            );
          }
          if(id==2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Safetytips()),
            );
          }
          if(id==3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Fakecallui()),
            );
          }
          if(id==4){
            print("User Guidence");
          }
        },
        child: Container(
          height: mq.height*0.06,
          width: mq.width*0.8,

          decoration: BoxDecoration(
            // color: Colors.grey, // Set the background color
            border: Border.all(
              color: Colors.blue, // Set the border color
              width: 2.0, // Set the border width
            ),
            borderRadius: BorderRadius.circular(10), // Optional: Add rounded corners
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,// Center align the content
            children: [
              Padding(
                padding: EdgeInsets.only(left: mq.width*0.03),
                child: Icon(
                  icon.icon, // Use the IconData stored in the Icon widget
                  size: mq.height * 0.04, // Set the dynamic size here
                  color: icon.color, // Retain the color from the original Icon, if necessary
                ),
              ),
              SizedBox(width: mq.width*0.04,), // Add some spacing between icon and text
              Text(
                title, // Replace with your desired text
                style: TextStyle(
                  fontSize: 24.0, // Adjust text size
                  color: Colors.black,
                  fontFamily: 'normal',// Set text color
                  fontWeight: FontWeight.normal, // Optional: Bold text
                ),
              ),
            ],
          ),

        ),
      );


  }
}
