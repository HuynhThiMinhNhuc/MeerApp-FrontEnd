import 'package:get_it/get_it.dart';
import 'controllers/controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<PostController>(() => PostController());
}