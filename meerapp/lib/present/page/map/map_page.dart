import 'dart:async';
import 'dart:developer';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/models/status_compaign.dart';
import 'package:meerapp/present/models/status_emerency.dart';
import 'package:meerapp/present/page/home_page/detail_campaign_page.dart';
import 'package:meerapp/present/page/urgent_page/detail_emerency_page.dart';

import '../../../models/map.dart';

class MapPage extends StatefulWidget {
  final String currentMarkerId = "test"; // ? Get account id

  final CameraPosition initialCameraPosition = CameraPosition(
    target: DefaultLatLng,
    zoom: 17,
  );
  final CustomInfoWindowController _infoWindowController =
      CustomInfoWindowController();
  final MapController _mapController = sl.get<MapController>();

  MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late List<bool> stateToggle = [true, false];
  bool isLoadingPosts = false;

  Marker? currentLocation;
  late final List<IMapObject> nearEventLocation;
  Set<Marker> get allMarker {
    var set = nearEventLocation.map((element) => createMaker(element)).toSet();
    if (currentLocation != null) set.add(currentLocation!);
    return set;
  }

  @override
  void initState() {
    super.initState();
    nearEventLocation = [];
  }

  @override
  void dispose() {
    widget._infoWindowController.dispose();
    super.dispose();
  }

  void setMainPositionTo(LatLng position) {
    widget._infoWindowController.googleMapController!.animateCamera(
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
    setMainPositionTo(currentLocation!.position);
  }

  void _getNearPost() {
    final List<Future> listTask = [];
    setState(() {
      isLoadingPosts = true;
    });

    if (stateToggle[0]) {
      listTask.add(widget._mapController.getCampaignsMap(
        (currentLocation?.position ?? widget.initialCameraPosition.target)
            .latitude,
        (currentLocation?.position ?? widget.initialCameraPosition.target)
            .longitude,
      ));
    }
    if (stateToggle[1]) {
      listTask.add(widget._mapController.getEmergenciesMap(
        (currentLocation?.position ?? widget.initialCameraPosition.target)
            .latitude,
        (currentLocation?.position ?? widget.initialCameraPosition.target)
            .longitude,
      ));
    }

    Future.wait(listTask).then((listTwo) {
      setState(() {
        nearEventLocation.clear();
        for (List<IMapObject> posts in listTwo) {
          nearEventLocation.addAll(posts);
        }
      });
    }).onError((error, stackTrace) {
      log(error?.toString() ?? "Cannot find posts");
    }).then((value) {
      setState(() {
        isLoadingPosts = false;
      });
    });
  }

  void _mockData() {
    IMapObject mapObject = CampaignMap(
      id: 1,
      lat: DefaultLatLng.latitude,
      lng: DefaultLatLng.longitude,
      title: 'test vị trí',
      time: DateTime.now(),
    );
    IMapObject map3Object = EmergencyMap(
      id: 2,
      lat: DefaultLatLng.latitude + 0.005,
      lng: DefaultLatLng.longitude,
      title: 'test vị trí 2',
      // time: DateTime.now(),
    );
    IMapObject map2Object = EmergencyMap(
      id: 3,
      lat: DefaultLatLng.latitude - 0.002,
      lng: DefaultLatLng.longitude + 0.003,
      title: 'test vị trí 3',
    );

    nearEventLocation.add(mapObject);
    nearEventLocation.add(map2Object);
    nearEventLocation.add(map3Object);
  }

  @override
  Widget build(BuildContext context) {
    // ? Mock data
    // _mockData();

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: widget.initialCameraPosition,
            onMapCreated: (controller) async {
              widget._infoWindowController.googleMapController = controller;
              // await _getCurrentLocation().onError((error, stackTrace) => log("cannot get current location"));
              _getNearPost();
            },
            onCameraMove: (position) =>
                {widget._infoWindowController.onCameraMove!()},
            onTap: (position) =>
                {widget._infoWindowController.hideInfoWindow!()},
            markers: allMarker,
          ),
          CustomInfoWindow(
            controller: widget._infoWindowController,
            height: 55,
            width: 150,
            offset: 50,
          ),
          Positioned.fill(
            top: 30.h,
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildToggleButton(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildToggleButton() {
    return Container(
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
        onPressed: isLoadingPosts
            ? null
            : (index) => setState(() {
                  stateToggle[index] = !stateToggle[index];
                  log('onClick toggle button, button[$index]=${stateToggle[index]}');
                  _getNearPost();
                }),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
            child: const Text(
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
    );
  }

  LatLng convertFromPositionToLatLng(Position position) {
    return LatLng(position.latitude, position.longitude);
  }

  Marker createMaker(IMapObject mapObject) {
    var newMarker = Marker(
        markerId: MarkerId(
            mapObject.id.toString() + mapObject.runtimeType.toString()),
        position: mapObject.position,
        icon: _getIcon(mapObject),
        onTap: () {
          //location
          widget._infoWindowController.addInfoWindow!(
            MyCustomInfoWindow(object: mapObject),
            mapObject.position,
          );
        });

    return newMarker;
  }

  BitmapDescriptor _getIcon(IMapObject mapObject) {
    if (currentLocation != null &&
        mapObject.position.latitude == currentLocation!.position.latitude &&
        mapObject.position.longitude == currentLocation!.position.longitude) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
    if (mapObject is CampaignMap) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    } else if (mapObject is EmergencyMap) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    }
    throw Exception("Not check the mapObject");
  }
}

class MyCustomInfoWindow extends StatelessWidget {
  final PostController _postController = sl.get<PostController>();

  MyCustomInfoWindow({
    Key? key,
    required this.object,
  }) : super(key: key);

  final IMapObject object;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //TODO: add loading widget
        if (object is EmergencyMap) {
          var post = await _postController.getEmergencyPostById(object.id);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetailEmerencyPage(
              mode: StatusEmerency.nonadmin,
              post: post,
            );
          }));
        } else if (object is CampaignMap) {
          var post = await _postController.getCampaignPostById(object.id);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetailCampaignPage(
              mode: StatusCompaign.nonMember,
              post: post,
            );
          }));
        }
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
                object.title,
                //mapObject.name,
                style:
                    kText13BoldBlack.copyWith(overflow: TextOverflow.ellipsis),
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
    );
  }
}
