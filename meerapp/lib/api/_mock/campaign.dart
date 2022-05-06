import 'dart:convert';
import 'dart:developer';

import 'package:meerapp/api/_mock/csv/main.dart';

class MockCampaign {
  static Future<Iterable<dynamic>> list() async {
    var list = await CSVHelper.readCSV("assets/mocks/campaign.csv");
    return list;
  }
}
