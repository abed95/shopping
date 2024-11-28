import 'package:flutter/material.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/modules/login_screen/cubit_login/cubit_login.dart';
import 'package:shoping/modules/register_screen/cubit_regisiter/cubit_register.dart';
import 'package:shoping/modules/search/cubit_search/cubit_search.dart';
import 'package:shoping/modules/splash_screen/splash_screen.dart';
import 'package:shoping/shared/components/bloc_observer.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';
import 'package:shoping/shared/networks/remote/dio_helper.dart';
import 'package:shoping/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared/components/constants.dart';

void main() async {
  //Ensure that these lines are run before the app started
  WidgetsFlutterBinding.ensureInitialized();
  //this bloc for show the states in console
  Bloc.observer = MyBlocObserver();
  //run the APIS handling library
  DioHelper.init();
  // initialize the shared preference file
  await CacheHelper.init();
  // run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // create all providers when run the app for the first time
    bool insideMainMode = CacheHelper.getData(key: 'isDark');
    print('$insideMainMode insideMainMode');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopLoginCubit()),
        BlocProvider(create: (context) => ShopRegisterCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoriteData()
              ..getUserData()),
      ],
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: HomeCubit.get(context).isDarkCubit
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),

    );
  }
}
