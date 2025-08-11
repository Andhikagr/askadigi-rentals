import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  Future<void> preloadDashboardImages(BuildContext context) async {
    final List<String> brandAssets = [
      "assets/image/toyota.png",
      "assets/image/honda.png",
      "assets/image/hyundai.png",
      "assets/image/daihatsu.png",
      "assets/image/suzuki.png",
      "assets/image/mitsubishi.png",
      "assets/image/man.png",
      "assets/image/coverred.jpg",
    ];

    for (final image in brandAssets) {
      await precacheImage(AssetImage(image), context);
    }
  }

  late final AnimationController _logoController;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    // Setup animasi logo (opacity dan scale)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoController.forward();

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      await preloadDashboardImages(context);
      if (!mounted) return;
      Get.delete<NavController>(force: true);
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, animation, secondaryAnimation) => Mainpage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload gambar agar tidak telat tampil
    precacheImage(const AssetImage("assets/image/coverred.jpg"), context);
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/image/coverred.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Image.asset("assets/image/backone.png", fit: BoxFit.cover),
            ),

            // Logo with Fade + Scale animation
            FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Center(
                  child: Image.asset(
                    "assets/image/rental.png",
                    width: context.longp(0.4),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
