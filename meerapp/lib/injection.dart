import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meerapp/config/constant.dart';
import 'controllers/controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<PostController>(() => PostController());
  sl.registerLazySingleton<MapController>(() => MapController());

  sl.registerSingleton<Dio>(Dio()..options.connectTimeout = timeoutHttp * 1000);
}