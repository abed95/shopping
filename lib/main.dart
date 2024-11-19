import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping/shared/components/bloc_observer.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';
import 'package:shoping/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() {
 // WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  // CacheHelper.init();

  //bool? isDark = CacheHelper.getBool(key: 'isDark');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home:  OnBoardingScreen(),
      );
  }
}