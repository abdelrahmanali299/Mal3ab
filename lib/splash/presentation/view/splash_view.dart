import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mal3ab/core/cache_helper.dart';
import 'package:mal3ab/features/auth/presentation/login/views/login_view.dart';
import 'package:mal3ab/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:mal3ab/features/profile/presentation/views/widgets/profile_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      bool isOnBoardingSeen = CacheHelper.getBool('isOnBoardingSeen') ?? false;
      bool login = CacheHelper.getBool('login') ?? false;

      isOnBoardingSeen
          ? login
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ProfileView()),
                  )
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginView()),
                  )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => OnBoardingView()),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/images/Football Animation with the Path.json',
          height: 300.h,
          width: 300.w,
        ),
      ),
    );
  }
}
