import 'package:flory/data/repositories/authentication/authentication_repository.dart';
import 'package:flory/features/shop/controllers/address_controller.dart';
import 'package:flory/utils/local_storage/storage_utility.dart';
import 'package:flory/utils/theme/theme_manager.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'features/authentication/controllers/login_controller/user_controller.dart';
import 'firebase_options.dart';
import 'app.dart';

import 'notifications/notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  /// Widgets Binding
  final  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // await FirebaseNotification().initNotification();

  await ThemeManager.init();

  /// GetX local storage
  await GetStorage.init();
  await TLocalStorage.init('cartBox');


  //Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// --  Initialize Firebase&Authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository()));
  Get.put(UserController());
  Get.put(AddressController());

  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  runApp(const App());
}