import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_a_18/translation.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late BannerAd _ad;
  late bool _isLoaded;
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    translations: Messages(), // your translations
    locale: Get.deviceLocale, // translations will be displayed in that locale
    fallbackLocale: Locale('en', 'US'),
      title: '35',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: colorPalette.blackpearl,
        ),
        cardTheme: CardTheme(
          color: colorPalette.watermelon
        ),
        scaffoldBackgroundColor: colorPalette.mirage,
      ),
      home: Splash(),
    );
  }
}

