import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/models/search_model.dart';
import 'package:shoping/modules/search/cubit_search/cubit_search.dart';
import 'package:shoping/modules/search/cubit_search/search_states.dart';
import 'package:shoping/shared/components/components.dart';
import 'package:shoping/shared/styles/colors.dart';

import '../../layouts/shop_layout/cubit_home/cubit_home.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text('Search any Product'),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  editTextForm(
                      controller: searchController,
                      label: 'Search',
                      prefixIcon: Icons.search,
                      validator: (String? value){
                        if (value!.isEmpty) {
                          return 'You must enter search key';
                        }
                      },
                    onSubmit: (String? text){
                        SearchCubit.get(context).search(text);
                    },
                  ),
                  SizedBox(height: 10,),
                  if(state is SearchLoadingState)
                  LinearProgressIndicator(color: defaultColor,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)
                      =>buildProductItem(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice:false),
                      separatorBuilder: (context,index)=>myDivider(),
                      itemCount: SearchCubit.get(context).model!.data!.data!.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
