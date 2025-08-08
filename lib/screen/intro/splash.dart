import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
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

    // Mulai animasi logo
    _logoController.forward();

    // Navigasi ke halaman login setelah 3 detik dengan animasi fade
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 2000),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Login(),
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
