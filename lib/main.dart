import 'package:flutter/material.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/shop_home_layout.dart';
import 'package:shoping/modules/login_screen/cubit_login/cubit_login.dart';
import 'package:shoping/modules/login_screen/login_screen.dart';
import 'package:shoping/shared/components/bloc_observer.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';
import 'package:shoping/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  bool onboarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  String token = CacheHelper.getData(key: 'token') ?? '';
  if (onboarding) {
    widget = (token.isNotEmpty) ? ShopHomeLayout() : LoginScreen();
    print('Start Widget: $widget');

  } else {
    widget = OnBoardingScreen();
    print('Start Widget: $widget');

  }

  runApp(
      MyApp(
    startWidget: widget,
        isDark: isDark,
      )
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool? isDark;

  const MyApp({required this.startWidget, required this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ShopLoginCubit()),
        BlocProvider(create: (context)=> HomeCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home:  startWidget,
        ),
    );
  }
}