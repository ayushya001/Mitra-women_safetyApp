import 'package:flutter/material.dart';

import '../Utils/AppComponentsColor.dart';
import '../Utils/general_utils.dart';


class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController _Firstname = TextEditingController();
  TextEditingController _Profession = TextEditingController();
  TextEditingController _age = TextEditingController();

  FocusNode firstnameFocusNode = FocusNode();
  FocusNode _professionNode = FocusNode();
  FocusNode _agenode = FocusNode();

  var _isTrue = false;

  @override
  Widget build(BuildContext context) {
    // final authprovider = Provider.of<Authprovider>(context,listen: false);
    // final imageprovider = Provider.of<ImageProviderClass>(context,listen: false);


    print("whole rebuilt Deatails page");
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04,top: MediaQuery.of(context).size.height*0.00),
                  child: Image.asset('assets/images/wmen.png',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height*0.3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text("Profile details",
                    style: TextStyle(
                      fontFamily: 'cursive',
                      fontWeight: FontWeight.bold,
                      fontSize:60,
                    ),),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: TextFormField(
                      controller: _Firstname,
                      keyboardType: TextInputType.text,
                      focusNode: firstnameFocusNode,
                      decoration: InputDecoration(
                        hintText: "Enter your Name",
                        hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                        labelText: "Name",
                        labelStyle: TextStyle(color: Appcolors.labelColor),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
                        ),


                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
                        ),

                      ),

                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(
                    controller: _Profession,
                    keyboardType: TextInputType.text,
                    focusNode: _professionNode,
                    decoration: InputDecoration(
                      hintText: "Enter your Profession",
                      hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                      labelText: "Profession",
                      labelStyle: TextStyle(color: Appcolors.labelColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
                      ),


                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
                      ),

                    ),

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(
                    controller: _age,
                    keyboardType: TextInputType.number,
                    focusNode: _agenode,
                    decoration: InputDecoration(
                      hintText: "Enter your Age",
                      hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                      labelText: "Age",
                      labelStyle: TextStyle(color: Appcolors.labelColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
                      ),


                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
                      ),

                    ),

                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),

          ElevatedButton(
            onPressed: (){
              _isTrue = true;
              setState(() {

              });

            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Appcolors.RoundbuttonColor),
              fixedSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.06)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Set the circular border radius here
                ),
              ),
            ), child:   _isTrue?Center(
            child: CircularProgressIndicator(color: Colors.white,),
          ):Center(
            child: Text("Submit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'cursive'
              ),


            ),
          ),
            // child: Consumer<Authprovider>(
            //     builder: (context, authprovider, child) {
            //       return authprovider.loading
            //           ? Center(
            //           child: CircularProgressIndicator(backgroundColor: Colors.white))
            //           : Center(
            //         child: Text(
            //           title,
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 16
            //           ),
            //         ),
            //       );
            //     }
            // ),


          )




                //0902cs211016





              ],
            ),
          ),
        )
    );
  }
}
