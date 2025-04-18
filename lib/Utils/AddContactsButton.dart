import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/Pages/SearchAndaddContacts.dart';
import 'package:women_safety/Utils/AddContactProvider.dart';

class Addcontactsbutton extends StatefulWidget {
  final VoidCallback onTap;
  const Addcontactsbutton({super.key, required this.onTap});

  @override
  State<Addcontactsbutton> createState() => _AddcontactsbuttonState();
}

class _AddcontactsbuttonState extends State<Addcontactsbutton> {
  bool _isPressed = false;

  void _handleTapDown(BuildContext context) {
    Provider.of<ContactButtonProvider>(context, listen: false).setPressed(true);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Searchandaddcontacts()),
    );
  }

  void _handleTapUp(BuildContext context) {
    Provider.of<ContactButtonProvider>(context, listen: false).setPressed(false);
    widget.onTap(); // Call SOS function
  }

  @override
  Widget build(BuildContext context) {

    // Fetch the current button state
    final isPressed = Provider.of<ContactButtonProvider>(context).isPressed;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTapDown: (_) => _handleTapDown(context),
        onTapUp: (_) => _handleTapUp(context),
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withOpacity(0.3),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: MediaQuery.of(context).size.width * 0.47,
          height: MediaQuery.of(context).size.height * 0.3,
          transform: Matrix4.identity()..scale(isPressed ? 0.95 : 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.contacts,
                color: Colors.white,
                size: 80,
              ),
              Positioned(
                bottom: 20,
                child: Text(
                  "Add Contacts",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
