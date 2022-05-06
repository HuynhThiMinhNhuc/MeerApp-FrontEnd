import 'package:meerapp/socketio/event/_default.dart';

class UserNearby {}

class SocketIOEvent {
  static final nearByUserUpdated = EventHandler<Function(List<UserNearby>)>();
}
