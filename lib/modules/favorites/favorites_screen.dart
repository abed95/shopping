import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition:
              state is! GetFavoritesLoadingState
                  && cubit.favoriteModel != null
                   && cubit.favoriteModel!.data!.data!.length != 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildProductItem(
                cubit.favoriteModel!.data!.data![index].product, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favoriteModel!.data!.data!.length,
          ),
          fallback: (context) => Center(
              child: Text(
            'No Favorite Product Yet ... Add some ^_^',
          ),
          ),
        );
      },
    );
  }
}
