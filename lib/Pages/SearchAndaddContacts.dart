import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/SearchingWidget.dart';
import '../provider/AddProvider.dart';
import '../provider/SearchProvider.dart';

class Searchandaddcontacts extends StatefulWidget {
  const Searchandaddcontacts({super.key});

  @override
  State<Searchandaddcontacts> createState() => _SearchandaddcontactsState();
}

class _SearchandaddcontactsState extends State<Searchandaddcontacts> {





  @override
  Widget build(BuildContext context) {
    final curr = FirebaseAuth.instance.currentUser?.uid;

    final searchProvider = Provider.of<SearchProvider>(context);
    final addProvider = Provider.of<AddProvider>(context);
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: mq.width * 0.018, top: mq.height * 0.040, right: mq.width * 0.018),
        child: Column(
          children: [
            TextField(
              controller: searchProvider.searchController,
              onChanged: searchProvider.searchUsers,
              decoration: InputDecoration(
                hintText: "Search by mobile or Gmail...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child:searchProvider.searchController.text.isEmpty
                  ? Center(child: Text("Search your close ones."
              ,style: TextStyle(
                    fontFamily: 'cursive',
                  fontSize: 28,
                ),
              ))// Hide everything if search field is empty
                  :
              searchProvider.searchResults.isEmpty
                  ? Center(child: Text("No results found"
              ,style: TextStyle(
                  fontFamily: 'cursive',
                  fontSize: 28,

                ),
              ),
              )
                  : ListView.builder(
                itemCount: searchProvider.searchResults.length,
                itemBuilder: (context, index) {
                  var user = searchProvider.searchResults[index];

                  // Check if the user already exists in contacts
                  bool isAdded = addProvider.isUserAdded(user['uid']);

                  return SearchingWidget(
                    name: user['name'],
                    accnt: user['accnt'],
                    isExist: isAdded, // Pass the correct state
                    onAdd: () {
                      FirebaseFirestore.instance.collection('Users').doc(curr).get().then((docSnapshot) {
                        if (docSnapshot.exists) {
                          var data = docSnapshot.data() as Map<String, dynamic>?;

                          if (data != null && data.containsKey('Contacts')) {
                            List<dynamic> contacts = data['Contacts'];

                            bool exists = contacts.any((contact) => contact['uid'] == user['uid']);

                            if (exists) {
                              // REMOVE user from contacts
                              FirebaseFirestore.instance.collection('Users').doc(curr).update({
                                'Contacts': FieldValue.arrayRemove([
                                  {'uid': user['uid']}
                                ])
                              }).then((_) {
                                addProvider.removeUser(user['uid']); // Update state
                              }).catchError((e) {
                                print("Error removing document: $e");
                              });
                            } else {
                              // ADD user to contacts
                              FirebaseFirestore.instance.collection('Users').doc(curr).update({
                                'Contacts': FieldValue.arrayUnion([
                                  {'uid': user['uid']}
                                ])
                              }).then((_) {
                                addProvider.addUser(user['uid']); // Update state
                              }).catchError((e) {
                                print("Error updating document: $e");
                              });
                            }
                          } else {
                            // If 'Contacts' does not exist, create it and add user
                            FirebaseFirestore.instance.collection('Users').doc(curr).set({
                              'Contacts': [
                                {'uid': user['uid']}
                              ]
                            }, SetOptions(merge: true)).then((_) {
                              addProvider.addUser(user['uid']); // Update state
                            });
                          }
                        } else {
                          // If document doesn't exist, create it
                          FirebaseFirestore.instance.collection('Users').doc(curr).set({
                            'Contacts': [
                              {'uid': user['uid']}
                            ]
                          }).then((_) {
                            addProvider.addUser(user['uid']); // Update state
                          });
                        }
                      }).catchError((e) {
                        print("Error fetching document: $e");
                      });
                    },
                  );
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}



