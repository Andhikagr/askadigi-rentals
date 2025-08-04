import 'package:car_rental/help/help.dart';
import 'package:car_rental/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  late final AnimationController _buttonController;
  late final AnimationController _scaleController;

  late Animation<double> _buttonOpacity;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _buttonOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_buttonController);

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(seconds: 2), () {
      setState(() {});
      _buttonController.forward();
      _scaleController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _buttonController.dispose();
    _scaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/image/backtwo.png"),
          Positioned(
            top: context.deviceHeight * 0.10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1382DC),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    offset: Offset(3, 3),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(context.deviceWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get Your Cars",
                    style: GoogleFonts.archivoBlack(
                      fontWeight: FontWeight.bold,
                      fontSize: context.deviceWidth * 0.08,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Text(
                    "Fastest way to book cars without the hassle of \nwaiting and hanging for price ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.deviceWidth * 0.035,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: context.deviceHeight * 0.26,
            left: context.deviceWidth * 0.08,
            child: FadeTransition(
              opacity: _buttonOpacity,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: () async {
                    await _scaleController.reverse();
                    _scaleController.stop();
                    Get.to(
                      () => Login(),
                      transition: Transition.native,
                      duration: Duration(milliseconds: 600),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(context.deviceWidth * 0.025),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF1382DC),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's Started",
                          style: TextStyle(
                            color: const Color(0xFF1382DC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: context.deviceWidth * 0.02),
                        Icon(
                          Icons.arrow_forward,
                          color: const Color(0xFF1382DC),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
