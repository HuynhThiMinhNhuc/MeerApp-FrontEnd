import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/present/models/user.dart';

abstract class IMapObject {
  final int id;
  final LatLng position;
  final String name;
  final DateTime time;

  IMapObject({
    required this.id,
    required this.position,
    required this.name,
    required this.time,
  });
}

class CampaignMap extends IMapObject {
  CampaignMap({
    required int id,
    required LatLng position,
    required String name,
    required DateTime time,
  }) : super(
          id: id,
          position: position,
          name: name,
          time: time,
        );
}

class EmergencyMap extends IMapObject {
  EmergencyMap({
    required int id,
    required LatLng position,
    required String name,
    required DateTime time,
  }) : super(
          id: id,
          position: position,
          name: name,
          time: time,
        );
}

class UserMap extends IMapObject {
  UserMap({
    required int id,
    required LatLng position,
    required String name,
    required DateTime time,
  }) : super(
          id: id,
          position: position,
          name: name,
          time: time,
        );
}