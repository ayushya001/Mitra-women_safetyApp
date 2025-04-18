import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProvider extends ChangeNotifier {
  Set<String> _addedUsers = {};

  bool isUserAdded(String uid) => _addedUsers.contains(uid);

  void addUser(String uid) {
    _addedUsers.add(uid);
    notifyListeners();
  }

  void removeUser(String uid) {
    _addedUsers.remove(uid);
    notifyListeners();
  }

  Future<void> initializeFromFirebase(String currUserId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('Users').doc(currUserId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('Contacts')) {
          final List contacts = data['Contacts'];
          _addedUsers = contacts.map<String>((c) => c['uid'] as String).toSet();
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error initializing contacts from Firebase: $e');
    }
  }
}
