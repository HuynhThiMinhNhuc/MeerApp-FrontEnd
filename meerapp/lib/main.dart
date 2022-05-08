import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/present/rootapp.dart';
import 'package:meerapp/singleton/user.dart';
import 'injection.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  UserSingleton.instance;
  runApp(const MeerApp());
}

class MeerApp extends StatelessWidget {
  const MeerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserSingleton.instance.refreshUserInfo();
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
          home: const RootApp()),
    );
  }
}
