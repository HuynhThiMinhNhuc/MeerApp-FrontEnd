import 'package:intl/intl.dart';

bool isImageURL(String text) {
  return text.startsWith('uploads/');
}

String DateTimeToString(DateTime time) {
  return "lúc " + DateFormat('h:mm').format(time) + 'h, ngày ' + DateFormat('d/M/yyyy').format(time);
}