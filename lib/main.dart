import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/screen/intro/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(NavController());
  Get.put(OrderController());
  Get.put(AuthController());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        textTheme: GoogleFonts.radioCanadaBigTextTheme(),
      ),
      home: Splash(),
    );
  }
}
