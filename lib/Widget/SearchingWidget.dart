import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/provider/AddProvider.dart';

class SearchingWidget extends StatefulWidget {
  final String name;
  final String accnt;
  final VoidCallback onAdd;
  final bool isExist;



  SearchingWidget({
    required this.name,
    required this.accnt,
    required this.onAdd,
    required this.isExist,
  });


  @override
  State<SearchingWidget> createState() => _SearchingWidgetState();
}

class _SearchingWidgetState extends State<SearchingWidget> {
  @override
  Widget build(BuildContext context) {

    final searchProvider = Provider.of<AddProvider>(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(widget.accnt),
        trailing: widget.isExist  ?  IconButton(
          icon: Icon(Icons.check_circle, color: Colors.green,size: 32,),
          onPressed: () {
            widget.onAdd();
            // searchProvider.setAdded(false);

          },
        ) : IconButton(
          icon: Icon(Icons.add_circle, color: Colors.green, size: 32,),
          onPressed: () {
            // searchProvider.setAdded(true);
            widget.onAdd();
          },
        )
      ),
    );
  }
}
