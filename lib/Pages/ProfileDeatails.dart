import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety/Models/UsersModel.dart';
import 'package:women_safety/Pages/HomePage.dart';

import '../Utils/AppComponentsColor.dart';
import '../Utils/general_utils.dart';
import '../Widget/GestureButton.dart';
import '../provider/Signup_mobile.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController _Firstname = TextEditingController();
  TextEditingController _Profession = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _address = TextEditingController();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode _professionNode = FocusNode();
  FocusNode _ageNode = FocusNode();
  FocusNode _addressNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _Firstname.dispose();
    _Profession.dispose();
    _age.dispose();
    _address.dispose();
    firstnameFocusNode.dispose();
    _professionNode.dispose();
    _ageNode.dispose();
    _addressNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    FirebaseAuth auth = FirebaseAuth.instance;




    print("whole rebuilt");
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.12),
                    child: Text("Profile details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cursive',
                        fontSize: 42,
                        color: Colors.black,

                      ),),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),


                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Container(
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
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(
                    controller: _age,
                    keyboardType: TextInputType.number,
                    focusNode: _ageNode,
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
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(
                    controller: _address,
                    keyboardType: TextInputType.text,
                    focusNode: _addressNode,
                    decoration: InputDecoration(
                      hintText: "Enter your Address",
                      hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                      labelText: "Adress",
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
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? userEmail = prefs.getString('user_email'); // Correct way to retrieve the stored value
                    String? userMobile = prefs.getString('Mobile_no');
                    print("Email saved locally: $userEmail");
                    String accntd = (userEmail != null && userEmail.isNotEmpty) ? userEmail : (userMobile ?? '');


                    if(_Firstname.text.toString().isEmpty){
                      print("yes firstname is empty");
                      Utils.flushBarErrorMessage("Enter your name", context);


                    }else if(_Profession.text.toString().isEmpty){
                      Utils.flushBarErrorMessage("Enter your Profession", context);

                    }else if(_age.text.toString().isEmpty){
                      Utils.flushBarErrorMessage("Enter Your age", context);
                    }else if(_address.text.toString().isEmpty){
                      Utils.flushBarErrorMessage("Enter your Address", context);
                    }else{
                      Provider.of<SignupMobile>(context, listen: false).setloading(true);

                      UsersModel user = UsersModel(
                        name: _Firstname.text.toString(),
                        age: _age.text.toString(),
                        uid :auth.currentUser!.uid,
                        address: _address.text.toString(),
                        profession: _Profession.text.toString(),
                        accnt: accntd,

                      );

                      FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid)
                          .set(user.toJson()).whenComplete(
                          (){
                            Provider.of<SignupMobile>(context, listen: false).setloading(true);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Homepage()),
                                  (Route<dynamic> route) => false, // This removes all previous routes from the stack
                            );
                          }


                      );


                    }




                    try {
                      //if i want to to firebaseoperation

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







              ],
            ),
          ),
        )
    );
  }
}
