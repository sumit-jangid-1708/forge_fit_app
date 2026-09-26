import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forge_fit_app/res/routes/routes.dart';
import 'package:forge_fit_app/res/routes/routes_name.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'res/app_theme/app_theme.dart';
import 'res/app_strings/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox("userBox");
  await Hive.openBox("workoutBox");
  await Hive.openBox("trackerBox");
  // Initialize persistent storage
  await GetStorage.init();

  // Force portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Transparent status bar — orange icons
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:                 Colors.transparent,
    statusBarIconBrightness:        Brightness.light,
    statusBarBrightness:            Brightness.dark,
    systemNavigationBarColor:       Color(0xFF000000),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const ForgeFitApp());
}

class ForgeFitApp extends StatelessWidget {
  const ForgeFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title:            AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // ─── Theme ────────────────────────────────────────────────
      theme:      AppTheme.darkTheme,
      darkTheme:  AppTheme.darkTheme,
      themeMode:  ThemeMode.dark, // always dark

      // ─── GetX Navigation ──────────────────────────────────────
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      getPages: AppRoutes.appRoute(),

      // ─── Initial Route ────────────────────────────────────────
      initialRoute: RouteName.splashScreen,
    );
  }
}
