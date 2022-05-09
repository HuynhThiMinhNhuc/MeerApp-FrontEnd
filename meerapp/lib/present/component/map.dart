import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/fontconfig.dart';

class MyMap extends StatefulWidget {
  final LatLng? initLocation;
  MyMap({Key? key, this.initLocation}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late final CameraPosition initialCameraPosition = CameraPosition(
      target: widget.initLocation ?? LatLng(
        DefaultLatLng.latitude,
        DefaultLatLng.longitude,
      ),
      zoom: 12);
  late GoogleMapController _controller;
  LatLng _chooseLocation = LatLng(
    DefaultLatLng.latitude,
    DefaultLatLng.longitude,
  );

  LatLng get chooseLocation => _chooseLocation;
  set chooseLocation(LatLng value) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: value,
      zoom: 12,
    )));
    _chooseLocation = value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    // Check GPS is open
    var isServiceLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceLocationEnabled) {
      return Future.error('Location service is disabled');
    }

    // Check permission is access
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      var request = await Geolocator.requestPermission();

      if (request == LocationPermission.denied ||
          request == LocationPermission.deniedForever) {
        return Future.error('Location service is denied');
      }
    }

    // Find current location
    var currentLocation = await Geolocator.getCurrentPosition();
    setState(() {
      chooseLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: meerColorBackground,
        iconTheme: const IconThemeData(color: meerColorBlackIcon),
        centerTitle: true,
        title: Text('Bản đồ', style: kText18BoldMain.copyWith(color: meerColorBlack),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, chooseLocation);
            },
            child: Text('Lưu',
               style: kText18BoldMain),
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) {
          _controller = controller;
        },
        onTap: (choosePosition) {
          setState(() {
            log('change location: ' + chooseLocation.toString());
            chooseLocation = choosePosition;
          });
        },
        markers: {
          Marker(
            markerId: const MarkerId("0"),
            position: chooseLocation,
          )
        },
      ),
    );
  }
}
