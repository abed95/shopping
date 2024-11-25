import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/cubit_home.dart';
import 'package:shoping/layouts/shop_layout/cubit_home/home_states.dart';
import 'package:shoping/shared/components/constants.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';
import 'package:shoping/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../login_screen/login_screen.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){
        if(state is GetUserSuccessState){
          nameController.text = state.userModel!.data!.name!;
          emailController.text = state.userModel!.data!.email!;
          phoneController.text = state.userModel!.data!.phone!;
        }
      },
      builder: (context,state){
        var cubit = HomeCubit.get(context);
        var model = HomeCubit.get(context).userModel;
        if(model !=null){
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        }
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                editTextForm(
                  controller: nameController,
                  label: 'Name',
                  prefixIcon: Icons.person,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                  },
                ),
                SizedBox(height: 20,),
                editTextForm(
                  controller: emailController,
                  label: 'Email address',
                  prefixIcon: Icons.email_outlined,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email must not be empty';
                    }
                  },
                ),
                SizedBox(height: 20,),
                editTextForm(
                  controller: phoneController,
                  label: 'Phone',
                  prefixIcon: Icons.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone must not be empty';
                    }
                  },
                ),
                SizedBox(height: 20,),
                defaultButton(
                    function: (){
                      },
                    text: 'update'
                ),
                SizedBox(height: 20,),
                defaultButton(
                    function: (){
                      signOut(context);
                    },
                    text: 'logout'
                ),
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
        );
      },
    );
  }
}
