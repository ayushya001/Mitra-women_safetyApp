import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety/Pages/PrivacyPolicyPage.dart';
import 'package:women_safety/Pages/SendFeedbackPage.dart';
import 'package:women_safety/Pages/contacts.dart';
import 'package:women_safety/Pages/settings.dart';
import 'package:women_safety/Utils/AddContactsButton.dart';

import '../Widget/Features.dart';
import '../Widget/SosButton.dart';
import '../provider/AddProvider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var currentPage ;


  @override
  void initState() {
    super.initState();

    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId != null) {
      // Call provider if needed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<AddProvider>(context, listen: false)
            .initializeFromFirebase(currentUserId);
      });

      // Listen to incoming SOS alerts
      FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserId)
          .collection('SOS')
          .snapshots()
          .listen((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final data = doc.data();
          final sosId = doc.id; // ✅ Get SOS document ID
          final receiverUid = currentUserId; // ✅ Use current user UID as receiver

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("🚨 SOS Alert"),
              content: Text(
                  "Sender shared location:\nLat: ${data['latitude']}\nLng: ${data['longitude']}"),
              actions: [
                TextButton(
                  child: Text("View on Map"),
                  onPressed: () {
                    final lat = data['latitude'];
                    final lng = data['longitude'];
                    final url =
                        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
                    launchUrl(Uri.parse(url));
                    Navigator.of(context).pop();

                    // ✅ Delete SOS after viewing
                    deleteSosAfterHandled(receiverUid, sosId);
                  },
                ),
                TextButton(
                  child: Text("Dismiss"),
                  onPressed: () {
                    Navigator.of(context).pop();

                    // ✅ Delete SOS after dismissing
                    deleteSosAfterHandled(receiverUid, sosId);
                  },
                )
              ],
            ),
          );
        }
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    print("whole rebuid");
    final mq = MediaQuery.of(context).size;




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,

        title: Text("Your Safety,Our Commitment",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'cursive',
              fontSize: 28,
              color: Colors.white
          ),
        ),
      ),

      drawer: Drawer(
        // backgroundColor: Colors.blueAccent,
        child: Container(
          child: Column(
            children: [
              MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.only(left: mq.width*0.02,top: mq.height*0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hii,",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cursive',
                    fontSize: 28,
                    color: Colors.black
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
              if (snapshot.hasError) {
               return Center(child: Text('Error: ${snapshot.error}'));
            }
            // Handle data state
               if (snapshot.hasData && snapshot.data!.exists) {
                 final userData = snapshot.data!.data() as Map<String, dynamic>;
                 return Text("   "+
                     userData['name'],
                   style: TextStyle(
                     fontSize: 28,
                     fontFamily:'cursive',
                     fontWeight: FontWeight.bold
                   ),


                 );
               }
                return Center(child: Text('No User Data Found'));


              }
              ),
              SizedBox(height: mq.height*0.02,),

              Row(
                children: [
                  SosButton(onTap: () {
                    sendSosToContacts();

                  },),
                  SizedBox(width: mq.width*0.02,),
                  Addcontactsbutton(onTap: (){

                  })
                ],
              ),
              SizedBox(height: mq.height*0.02,),
              Center(
                child: Features(title: "Near By safeSpots",
                    onpress: (){

                    },
                    icon: Icon(Icons.location_on), id: 1,

              ),
              ),
              SizedBox(height: mq.height*0.025,),
              Center(
                child: Features(title: "Safety Tips", onpress: (){},
                    icon: Icon(Icons.tips_and_updates),id: 2,
                ),

              ),
              SizedBox(height: mq.height*0.025,),
              Center(
                  child: Features(title: "Fake Call", onpress: (){},
                      icon: Icon(Icons.call),
                    id: 3,
                  )
              ),
              SizedBox(height: mq.height*0.025,),
              Center(
                  child: Features(title: "User Guidence", onpress: (){},
                      icon: Icon(Icons.help_outline)
                  ,id: 4,)
              ),
              SizedBox(height: mq.height*0.025,),

            ],
          ),
        ),
      )
    );
  }
  Widget MyHeaderDrawer(){
    return Container(
      width: double.infinity,
      color: Colors.blueAccent,
      height: MediaQuery.of(context).size.height*0.35,
      child: Padding(
        padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.07,left: MediaQuery.of(context).size.width*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.amberAccent, // Golden yellow color
                    width: 1,         // Thickness of the border
                  ),

                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/wmen.png')
                )
              ),
            ),

            Text(
              "Welcome,",
              style: TextStyle(
                fontFamily: 'cursive',
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),

            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  // Handle data state
                  if (snapshot.hasData && snapshot.data!.exists) {
                    final userData = snapshot.data!.data() as Map<String, dynamic>;
                    return Text("     "+
                        userData['name'],
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily:'cursive',
                          fontWeight: FontWeight.bold
                      ),


                    );
                  }
                  return Center(child: Text('No User Data Found'));


                }
            ),
          ],
        ),
      ),

    );
  }
  Widget MyDrawerList(){
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
      child: Column(
        //menu item
        children: [
          menuItem(1, "Contacts", Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(2, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(3, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(4, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),
          menuItem(5, "Help", Icons.help_outline_outlined,
              currentPage == DrawerSections.Help ? true : false),
        ],

      ),
    );
  }

  void sendSosToContacts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Get current location
    final position = await getCurrentPosition(); // your location function
    print("The current position is: ${position.toString()}");

    final baseSosData = {
      'senderId': user.uid,
      'latitude': position?.latitude,
      'longitude': position?.longitude,
      'timestamp': Timestamp.now(),
    };

    final contactsSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    final contacts = contactsSnapshot.data()?['Contacts'] ?? [];

    for (var contact in contacts) {
      // Create a document reference with an auto-generated ID
      final docRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(contact['uid'])
          .collection('SOS')
          .doc();

      // Add sosId in the data
      final sosData = {
        ...baseSosData,
        'sosId': docRef.id,
      };

      await docRef.set(sosData); // Save the SOS with sosId
    }
  }


  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      print('Location services are disabled.');
      return null;
    }

    // Check and request permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        print('Location permissions are denied.');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      print('Location permissions are permanently denied.');
      return null;
    }

    // When permission is granted, get the position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> deleteSosAfterHandled(String receiverUid, String sosId) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverUid)
        .collection('SOS')
        .doc(sosId)
        .delete();
  }
  void setupFCMListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null && context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("🚨 SOS Alert"),
            content: Text(message.notification!.body ?? 'SOS Received!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Dismiss"),
              ),
            ],
          ),
        );
      }
    });
  }

  Widget menuItem(int id, String title, IconData icon, bool selected){
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: (){
          // Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.contacts;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => contacts()),
              );
              // currentPage = DrawerSections.contacts;
              currentPage = null;

            }  else if (id == 2) {
              currentPage = DrawerSections.settings;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settings()),
              );
              currentPage = null;


            }  else if (id == 3) {
              currentPage = DrawerSections.privacy_policy;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Privacypolicypage()),
              );
              currentPage = null;


            } else if (id == 4) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sendfeedbackpage()),
                );
                currentPage = null;


            }
            else if (id == 5) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sendfeedbackpage()),
              );
              currentPage = null;


            }
          });
        },
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.035),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon,size: 36,color: Colors.black,),
              SizedBox(width: MediaQuery.of(context).size.width*0.035,),
              Expanded(child: Text(title,style: TextStyle(color: Colors.black,fontSize: 24,fontFamily: 'cursive'),))
            ],

          ),
        ),

      ),
    );
  }
}
enum DrawerSections {
  contacts,
  settings,
  privacy_policy,
  send_feedback,
  logout,
  Help
}
