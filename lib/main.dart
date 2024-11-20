import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onboarding = CacheHelper.getData(key: 'onBoarding');
  runApp(MyApp(onBoarding: onboarding,isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  final bool? isDark;

  const MyApp({super.key, required this.onBoarding, required this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ShopLoginCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home:  onBoarding! ? LoginScreen(): OnBoardingScreen(),
        ),
    );
  }
}