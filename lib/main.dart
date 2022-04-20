import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/views/splashscreen/splashscreen_view.dart';
import 'static/color_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.white,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      title: 'Solog Warehousing TPR',
      theme: ThemeData(
        fontFamily: "Poppins",
        backgroundColor: const Color(0xFFE5E5E5),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          foregroundColor: Colors.black,
          color: Colors.white,
        ),
        dividerColor: Colors.grey[300],
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: "Poppins",
            ),
        primaryTextTheme: ThemeData.light().textTheme.apply(
              fontFamily: "Poppins",
            ),
        primaryIconTheme: IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        hintColor: ColorApp.mainColorApp,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.light(primary: ColorApp.mainColorApp),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashscreenView(),
    ));
  });
}
