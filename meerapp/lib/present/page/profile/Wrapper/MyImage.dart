import 'package:flutter/widgets.dart';

ImageProvider<Object> MyImage(String uri) {
  // Debug
  return AssetImage(uri);
  // Realtime
  return NetworkImage(uri);
}
