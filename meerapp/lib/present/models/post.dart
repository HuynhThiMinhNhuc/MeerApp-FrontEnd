import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/present/models/user.dart';

abstract class IPost {
  final int id;
  final LatLng position;
  final String name;
  final String description;
  final UserOverview creator;
  final DateTime time;

  IPost({
    required this.id,
    required this.position,
    required this.name,
    required this.description,
    required this.creator,
    required this.time,
  });
}

class CampaignMap extends IPost {
  CampaignMap({
    required int id,
    required LatLng position,
    required String name,
    required String description,
    required UserOverview creator,
    required DateTime time,
  }) : super(
          id: id,
          position: position,
          name: name,
          description: description,
          creator: creator,
          time: time,
        );
}

class EmergencyMap extends IPost {
  EmergencyMap({
    required int id,
    required LatLng position,
    required String name,
    required String description,
    required UserOverview creator,
    required DateTime time,
  }) : super(
          id: id,
          position: position,
          name: name,
          description: description,
          creator: creator,
          time: time,
        );
}
