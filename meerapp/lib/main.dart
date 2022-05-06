import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/_mock/campaign.dart';
import 'package:meerapp/present/rootapp.dart';

void main() {
  runApp(const MeerApp());
}

class MeerApp extends StatelessWidget {
  const MeerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  log("Done");
  MockCampaign.list().then((list) => log(jsonEncode(list)));
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: true,
        home: const RootApp()
      ),
    );
  }
}

