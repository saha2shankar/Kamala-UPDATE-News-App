import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamala_update/controller/home_controller.dart';
import 'package:kamala_update/services/notification_service.dart';
import 'package:kamala_update/utils/constants.dart';
import 'package:kamala_update/utils/route_utils.dart';
import 'package:kamala_update/utils/theme_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await NotificationService.getFCMToken();
  // Ensure Flutter is initialized
  await SharedPreferences.getInstance(); // Initialize shared_preferences
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize HomeController
    final HomeController homeController = Get.put(HomeController());

    return Obx(() => GetMaterialApp(
          title: Constants.appName,
          theme: CustomTheme.lightTheme, // Your light theme
          darkTheme: CustomTheme.darkTheme, // Your dark theme
          themeMode: homeController.isDarkModeOn.value
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          getPages: [...RouteUtils.routes],
          initialRoute: RouteUtils.home,
        ));
  }
}
