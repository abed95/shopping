import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/models/categories_model.dart';
import 'package:shoping/models/home_model.dart';
import 'package:shoping/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel!=null,
            builder: (context) => productBuilder(cubit.homeModel,cubit.categoriesModel),
            fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: defaultColor,
                )));
      },
    );
  }

  Widget productBuilder(HomeModel? homeModel , CategoriesModel? categoriesModel)
  => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel?.data?.banners
                  ?.map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildCategoriesItem(
                            categoriesModel.data!.data![index]
                        ),
                        separatorBuilder: (context,index)=>SizedBox(width: 10,),
                        itemCount: categoriesModel!.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                homeModel!.data!.products!.length,
                (index) => buildGridProduct(homeModel.data!.products![index]),
              ),
            ),
          ],
        ),
      );
}

Widget buildGridProduct(ProductModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart, children: [
          Image(
            image: NetworkImage(
              model.image ?? '',
            ),
            width: double.infinity,
            height: 200,
          ),
          if (model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

Widget buildCategoriesItem(DataModel? model)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(image: NetworkImage(model!.image??''),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    ),
    Container(
      color: Colors.black38,
      width: 100,
      child:  Text(
        model.name??'Categories Name',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ],
);