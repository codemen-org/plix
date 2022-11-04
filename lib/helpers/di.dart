import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void diSetup() {
  locator.registerLazySingleton(() => FirebaseMessaging.instance);
}
