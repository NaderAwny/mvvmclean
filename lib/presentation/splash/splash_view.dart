import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvmclean/presentation/resources/assets_manger.dart';
import 'package:mvvmclean/presentation/resources/color_manger.dart';
import 'package:mvvmclean/presentation/resources/constants_manger.dart';
import 'package:mvvmclean/presentation/resources/route_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
 //   Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primary,
      body: Center(
        child:
        SvgPicture.asset(ImageAssets.logo1),
        
        // Image(image: AssetImage(ImageAssets.splashLogo)),
      ),
    );
  }
}
