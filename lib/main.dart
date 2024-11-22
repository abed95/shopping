import 'package:flutter/material.dart';
import 'package:shoping/modules/login_screen/cubit_login/cubit_login.dart';
import 'package:shoping/modules/splash_screen/splash_screen.dart';
import 'package:shoping/shared/components/bloc_observer.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';
import 'package:shoping/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {

  const MyApp();
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
          home:  SplashScreen(),
        ),
    );
  }
}