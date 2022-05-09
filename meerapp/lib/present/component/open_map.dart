import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/colorconfig.dart';
import '../../config/fontconfig.dart';
import 'map.dart';

class OpenMap extends StatelessWidget {
  final Function(LatLng?)? onChooseLocationFinish;
  final TextEditingController locationTextController;
  final LatLng? initLocation;
  OpenMap({
    Key? key,
    this.onChooseLocationFinish,
    required this.locationTextController,
    this.initLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: AssetImage("asset/location.png"), fit: BoxFit.cover)),
        ),
        Positioned(
            child: Container(
          height: 35.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                child: TextFormField(
                  readOnly: true,
                  textAlign: TextAlign.start,
                  style: kText13RegularBlack.copyWith(color: meerColorWhite),
                  controller: locationTextController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.angleRight,
                  color: meerColorBlack,
                  size: 20,
                ),
                onPressed: () async {
                  var location = await Navigator.of(context).push<LatLng?>(
                    MaterialPageRoute(
                      builder: (_) => MyMap(initLocation: initLocation),
                    ),
                  );
                  onChooseLocationFinish?.call(location);
                },
              )
            ],
          ),
          decoration: const BoxDecoration(
              color: Color.fromARGB(92, 0, 0, 0),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        ))
      ],
    );
  }
}
