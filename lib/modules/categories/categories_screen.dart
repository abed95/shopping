import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/models/categories_model.dart';
import 'package:shoping/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeCubit.get(context);
        return ListView.separated(
          itemBuilder: (context,index)=>buildCatItem(cubit.categoriesModel!.data!.data![index]),
          separatorBuilder: (context,index)=>myDivider(),
          itemCount: cubit.categoriesModel!.data!.data!.length,);
      },
    );
  }
}

Widget buildCatItem(DataModel? model)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(image: NetworkImage(
        model!.image??'',
      ),
        width: 80,
        height: 80,
      ),
      SizedBox(width: 20,),
      Text(model.name??'',style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios,),
    ],
  ),
);