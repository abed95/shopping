import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/modules/login_screen/login_screen.dart';
import 'package:shoping/shared/components/components.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';

class ShopHomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Salla',),
              ),
              body: Center(
              child: TextButton(
              onPressed: () {
            HomeCubit.get(context).Logout('token', context);
          },
          child: titleText(title: 'Sign Out'),
          ),
          ),
          );
        }
    );
  }
}
