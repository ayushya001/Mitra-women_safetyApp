import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../provider/SosButtonProvider.dart';

class SosButton extends StatefulWidget {
  final VoidCallback onTap;

  const SosButton({Key? key, required this.onTap}) : super(key: key);

  @override
  _SosButtonState createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> {
  bool _isPressed = false;

  void _handleTapDown(BuildContext context) {
    Provider.of<SosButtonProvider>(context, listen: false).setPressed(true);
  }

  void _handleTapUp(BuildContext context) {
    Provider.of<SosButtonProvider>(context, listen: false).setPressed(false);
    widget.onTap(); // Call SOS function
  }

  @override
  Widget build(BuildContext context) {









    // Fetch the current button state
    final isPressed = Provider.of<SosButtonProvider>(context).isPressed;

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
                LucideIcons.circleAlert,
                color: Colors.white,
                size: 80,
              ),
              Positioned(
                bottom: 20,
                child: Text(
                  "Send SOS",
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

