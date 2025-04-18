import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  void searchUsers(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      notifyListeners();
      return;
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('accnt', isGreaterThanOrEqualTo: query)
        .where('accnt', isLessThan: query + '\uf8ff') // Firestore text filtering
        .get();

    searchResults = querySnapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }
}
