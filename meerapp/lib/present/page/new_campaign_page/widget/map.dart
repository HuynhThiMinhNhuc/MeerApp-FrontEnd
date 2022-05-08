import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/config/constant.dart';

class MyMap extends StatefulWidget {
  MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(
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
        title: const Text('Bản đồ'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, chooseLocation);
            },
            child: const Text('Lưu'),
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
