import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/present/page/Login/login_view.dart';
import 'package:meerapp/present/rootapp.dart';
import 'package:meerapp/singleton/user.dart';
import 'injection.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await checkLogin();
  runApp(const MeerApp());
}

FutureOr<void> checkLogin() async {
  UserSingleton.instance;
  await UserSingleton.instance.loadAuth();
  await UserSingleton.instance.refreshUserInfo();
}

class MeerApp extends StatelessWidget {
  const MeerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      child: MaterialApp(
          localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
          supportedLocales: const [Locale('vi'), Locale('Vn')],
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: UserSingleton.instance.userInfoStream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Crashed"),
                );
              }
              if (snapshot.data == null) {
                return LoginPage();
              } else {
                return const RootApp();
              }
            },
          )),
    );
  }
}
