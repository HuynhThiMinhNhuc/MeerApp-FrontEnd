import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/models/status_compaign.dart';
import 'package:meerapp/present/page/home_page/detail_campaign_page.dart';

import '../../models/map.dart';

class MapPage extends StatefulWidget {
  final String currentMarkerId = "test"; // ? Get account id
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late CameraPosition initialCameraPosition;
  final CustomInfoWindowController _infoWindowController =
      CustomInfoWindowController();
  late List<bool> stateToggle =  [true, false];

  Marker? currentLocation;
  final Map<IMapObject, Marker> nearEventLocation = <IMapObject, Marker>{};
  Set<Marker> get allMarker {
    var set = nearEventLocation.values.toSet();
    if (currentLocation != null) set.add(currentLocation!);
    return set;
  }

  @override
  void initState() {
    super.initState();

    var lastKnowPosition = null; //await Geolocator.getLastKnownPosition();
    initialCameraPosition = CameraPosition(
      target: lastKnowPosition != null
          ? convertFromPositionToLatLng(lastKnowPosition)
          : DefaultLatLng,
      zoom: 15,
    );
  }

  @override
  void dispose() {
    _infoWindowController.dispose();
    super.dispose();
  }

  void setMainPosition(LatLng position) {
    // log("set position to: ${currentLocation!.position.toString()}");
    _infoWindowController.googleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 12,
        ),
      ),
    );
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
    var location = await Geolocator.getCurrentPosition();
    currentLocation = Marker(
        markerId: MarkerId(widget.currentMarkerId),
        position: convertFromPositionToLatLng(location),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
          // TODO: Show description
        },
        infoWindow: InfoWindow());
    setMainPosition(currentLocation!.position);
  }

  Future<void> _getNearMarker() async {
    // TODO: fetch api to get nearEventLocation
  }

  @override
  Widget build(BuildContext context) {
    // ? Mock data
    IMapObject mapObject = CampaignMap(
      id: 1,
      position: DefaultLatLng,
      name: 'test vị trí',
      time: DateTime.now(),
    );
    nearEventLocation.addEntries({mapObject: createMaker(mapObject)}.entries);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (controller) async {
              _infoWindowController.googleMapController = controller;
              // await _getCurrentLocation().onError((error, stackTrace) => log("cannot get current location"));
              await _getNearMarker();
            },
            onCameraMove: (position) => {_infoWindowController.onCameraMove!()},
            onTap: (position) => {_infoWindowController.hideInfoWindow!()},
            markers: allMarker,
          ),
          CustomInfoWindow(
            controller: _infoWindowController,
            height: 55,
            width: 150,
            offset: 50,
          ),
          Positioned.fill(
            top: 30.h,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: meerColorBackground,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(30),
                  fillColor: meerColorMain,
                  color: meerColorBlack,
                  selectedColor: meerColorWhite,
                  onPressed: (index) => setState(() {
                    stateToggle[index] = ! stateToggle[index];
                  }),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                      child:  const Text(
                        "Chiến dịch",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                      child: const Text(
                        "Khẩn cấp",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  isSelected: stateToggle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  LatLng convertFromPositionToLatLng(Position position) {
    return LatLng(position.latitude, position.longitude);
  }

  Marker createMaker(IMapObject mapObject) {
    var newMarker = Marker(
        markerId: MarkerId(mapObject.id.toString()),
        position: mapObject.position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          //location
          _infoWindowController.addInfoWindow!(
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const DetailCampaignPage(mode: StatusCompaign.admin);
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: meerColorWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: Change InfoWindow here
                      Text(
                        "Test the nay duoc hong",
                        //mapObject.name,
                        style: kText13BoldBlack.copyWith(
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Nhấn để xem chi tiết",
                        style: kText11RegularHintText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            mapObject.position,
          );
        });

    return newMarker;
  }
}
