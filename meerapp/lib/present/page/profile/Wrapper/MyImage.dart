import 'package:flutter/widgets.dart';
import 'package:meerapp/config/constant.dart';

final basePublicURI = ServerUrl + "/public/";
ImageProvider<Object> MyImage(String? uri, ImageProvider<Object> defaultImage) {
  // Debug
  //return AssetImage(uri);
  // Realtime
  if (uri == null) {
    return defaultImage;
  }

  if (!uri.startsWith(basePublicURI)) {
    uri = basePublicURI + uri;
  }

  return NetworkImage(uri);
}
