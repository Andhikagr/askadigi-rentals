import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/intro/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityController;
  late final Animation<double> _scaleController;

  //wipe
  late AnimationController _wipeController;
  late final Animation<double> _wipeOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _opacityController = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));

    _scaleController = Tween<double>(begin: 0.9, end: 1.0).animate(_controller);

    _controller.forward();

    _wipeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _wipeOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _wipeController, curve: Curves.easeOut));

    Future.delayed(Duration(seconds: 3), () async {
      if (!mounted) return;
      await _wipeController.forward();
      if (!mounted) return;
      Get.off(
        () => Onboarding(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 800),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _wipeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Scaffold(
        backgroundColor: surfaceColor(context),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/image/backone.png", fit: BoxFit.cover),
            ),
            FadeTransition(
              opacity: _opacityController,
              child: ScaleTransition(
                scale: _scaleController,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/logoaskadigi.png",
                        fit: BoxFit.cover,
                        width: context.shortp(0.8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: _wipeOpacity,
              child: Container(color: surfaceColor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
