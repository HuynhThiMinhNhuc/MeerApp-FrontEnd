import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class CSVHelper {
  static Future<List<Map<String, dynamic>>> readCSV(String key) async {
    final raw = await rootBundle.loadString(key);
    final rows = const CsvToListConverter().convert(raw);
    final header = rows[0];
    List<Map<String, dynamic>> rs = List.empty(growable: true);
    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      Map<String, dynamic> fields = {};
      for (int k = 0; k < header.length; k++) {
        fields[header[k]] = row[k];
      }
      rs.add(fields);
    }
    return rs;
  }
}

Future<List<Map<String, Object>>> getDataFromAsset(String key) async {
  final String raw = await rootBundle.loadString(key);

  final List<String> lines = const LineSplitter().convert(raw);
  // Lines[0] is column's name
  final columns = lines[0].split('\t');
  //log(lines[0]);
  // Get from lines[1] to the end
  return List.generate(lines.length - 1, (index) {
    final i = index + 1;
    final line = lines[i];
    final List<String> fields = line.split('\t');
    var values = Map<String, Object>.fromIterables(columns, fields);
    //log(line);
    //log(values.toString());
    return values;
  });
}
