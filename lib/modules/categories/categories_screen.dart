import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/models/categories_model.dart';
import 'package:shoping/shared/components/components.dart';
import 'package:shoping/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeCubit.get(context);
        var model = cubit.categoriesModel;
        return ConditionalBuilder(
          condition: model!=null,
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(model.data!.data![index]),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: model!.data!.data!.length,),
          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),

        );
      },
    );
  }
}

Widget buildCatItem(DataModel? model)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    mainAxisSize: MainAxisSize.max,
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