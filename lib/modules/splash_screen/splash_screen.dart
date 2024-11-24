import 'package:flutter/material.dart';
import 'package:shoping/shared/components/components.dart';
import '../../layouts/shop_layout/home_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../login_screen/login_screen.dart';
import '../on_boarding_screen/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
      bool onboarding = CacheHelper.getData(key: 'onBoarding') ?? false;
      token = CacheHelper.getData(key: 'token') ?? '';
      if (onboarding) {
        print(token);
        if(token!= ''){
          navigateAndFinish(context,HomeLayout());
        }else{
        navigateAndFinish(context,LoginScreen());
        }
      } else {
        navigateAndFinish(context, OnBoardingScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash',),),
    );
  }
}
