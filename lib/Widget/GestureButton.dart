import 'package:flutter/material.dart';

class Gesturebutton extends StatelessWidget {

  final String title;

  final VoidCallback onpress;
  final String imagePath;
  const Gesturebutton({super.key, required this.title, required this.onpress, required this.imagePath});




  @override
  Widget build(BuildContext context) {

    final mq = MediaQuery.of(context).size;
    return
       GestureDetector(
        onTap:(){
          onpress();
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
                padding: EdgeInsets.only(left: mq.width*0.06),
                child: Image.asset(
                  imagePath, // Replace with the path to your image
                  height: mq.height*0.08, // Adjust the image height
                  width: mq.width*0.08, // Adjust the image width
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


