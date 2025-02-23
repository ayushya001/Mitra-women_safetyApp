import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Nearbysafespots extends StatefulWidget {
  const Nearbysafespots({super.key});

  @override
  State<Nearbysafespots> createState() => _NearbysafespotsState();
}

class _NearbysafespotsState extends State<Nearbysafespots> {
  String _locationMessage = "Fetching location...";
  late GoogleMapController _mapController;
  LatLng _currentPosition = LatLng(0, 0);
  bool _loading = true;
  Set<Marker> _markers = {};
  String apiKey = "AIzaSyBZPeZLJpCwveZYy_x4Rrnvq94-NOj4m30"; // Replace with your API key
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body:SafeArea(
        child: _loading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 15,
            ),
          myLocationEnabled: true, // Enable blue dot for current location
          // myLocationButtonEnabled: true, // Add the location button
          markers: _markers,
            ),
      ),
      // Text(_locationMessage),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Location services are disabled.";
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
        "Location permissions are permanently denied. Enable permissions from settings.";
      });
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
    });
    await _fetchNearbyPlaces();
  }


  Future<void> _fetchNearbyPlaces() async {
    if (_currentPosition == null) {
      print("Current position not available yet!");
      return;
    }

    List<String> placeTypes = [
      "police",
      "hospital",
      "train_station",
      "bus_station",
      "taxi_stand"
    ];

    Set<Marker> newMarkers = {};
    double minLat = 90, maxLat = -90, minLng = 180, maxLng = -180;

    for (String placeType in placeTypes) {
      final url =
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition.latitude},${_currentPosition.longitude}&radius=5000&type=$placeType&key=$apiKey";

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['status'] == 'OK') {
            List results = data['results'];

            for (var result in results) {
              final lat = result['geometry']['location']['lat'];
              final lng = result['geometry']['location']['lng'];
              final name = result['name'];

              print("Fetched $placeType: $name");

              newMarkers.add(
                Marker(
                  markerId: MarkerId("${lat}_${lng}"),
                  position: LatLng(lat, lng),
                  infoWindow: InfoWindow(title: name, snippet: placeType),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed
                  ),
                ),
              );

              // Update bounds
              if (lat < minLat) minLat = lat;
              if (lat > maxLat) maxLat = lat;
              if (lng < minLng) minLng = lng;
              if (lng > maxLng) maxLng = lng;
            }
          } else {
            print("Error fetching $placeType: ${data['status']}");
          }
        } else {
          print("Failed to fetch $placeType: ${response.statusCode}");
        }
      } catch (e) {
        print("Error fetching $placeType: $e");
      }
    }

    setState(() {
      _markers = newMarkers;
    });

    // Automatically adjust camera to show all markers
    if (_markers.isNotEmpty) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );

      Future.delayed(Duration(milliseconds: 500), () {
        _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      });
    }
  }



}
