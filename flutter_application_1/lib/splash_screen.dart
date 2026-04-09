import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/auth/view/signup_view.dart';
import 'package:flutter_application_1/onbording_screens/onbording_root_screens.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _watchController;

  @override
  void initState() {
    super.initState();

    // Logo Animation
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();

    // Watch Animation
    _watchController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
      lowerBound: 0.9,
      upperBound: 1.0,
    )..forward();

    // Navigate after delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnbordingRootScreens()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _watchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorsinapp,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 250),

       

        

            // Watch (Subtle scale)
            ScaleTransition(
              scale: _watchController,
              child: Image.asset("assets/images/Logo_Splash_Screen.png"),
            ),
          ],
        ),
      ),
    );
  }
}
