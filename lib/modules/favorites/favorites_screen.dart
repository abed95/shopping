import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/models/favorite_model.dart';
import 'package:shoping/shared/components/components.dart';
import 'package:shoping/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition:state is! GetFavoritesLoadingState ,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildFavItem(cubit.favoriteModel!.data!.data![index],context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: cubit.favoriteModel!.data!.data!.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
        );
      },
    );
  }
}

Widget buildFavItem(FavoriteData model, context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120,
    child: Row(
      children: [
        Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.product!.image ?? '',
                ),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product!.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.product!.price.round()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context).changeFavorites(model.product!.id);
                      print(model.product!.id);
                    },
                    padding: EdgeInsets.zero,
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                      HomeCubit.get(context).favorite[model.id] ?? false
                          ? defaultColor
                          : Colors.grey,
                      child: const Icon(
                        Icons.favorite_border_outlined,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);