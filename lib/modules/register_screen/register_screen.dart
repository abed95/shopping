import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/modules/register_screen/cubit_regisiter/cubit_register.dart';
import 'package:shoping/modules/register_screen/cubit_regisiter/register_states.dart';
import 'package:shoping/shared/components/components.dart';

import '../../layouts/shop_layout/home_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget{

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
      listener: (context,state){
        if(state is ShopRegisterSuccessState){
          if(state.loginModel?.status == true)
          {
            print({'The state is :',state});
            print({'The Status of request is :',state.loginModel?.status});
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel?.data?.token,)
                .then((onValue){
              token = state.loginModel!.data!.token!;
            }).catchError((onError){
              print({'The error is :',onError});
            });

            CacheHelper.saveUserData(state.loginModel).then((onValue){
              navigateAndFinish(context, HomeLayout(),);
              showToast(message: state.loginModel?.message, state: ToastStates.SUCCESS);
            }).catchError((onError){
              showToast(message: state.loginModel?.message, state: ToastStates.ERROR);
            });
          }else{
            print({'The Status of request is :',state});
            showToast(
              state: ToastStates.ERROR,
              message: state.loginModel?.message,
            );
          }
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        titleText(title: 'Register', context: context),
                        bodyText(
                            body: 'Register now to browse an amazing offers',
                            context: context),
                        SizedBox(
                          height: 45,
                        ),
                        editTextForm(
                          controller: nameController,
                          label: 'User Name',
                          prefixIcon: Icons.person,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'You must enter your name';
                            }
                          },
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        editTextForm(
                          controller: emailController,
                          label: 'Email',
                          prefixIcon: Icons.email_outlined,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'You must enter an email';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        editTextForm(
                          controller: passwordController,
                          label: 'Password',
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          prefixIcon: Icons.lock,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixIconPressed: () {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validator: (String? value){
                            if (value!.isEmpty) {
                              return 'You must enter password';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        editTextForm(
                          controller: phoneController,
                          label: 'Phone number',
                          prefixIcon: Icons.phone,
                          validator: (String? value){
                            if (value!.isEmpty) {
                              return 'You must enter phone number';
                            }
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context)=>defaultButton(
                            function: () {
                              print('inside Button');
                              FocusScope.of(context).unfocus();
                              if(formKey.currentState!.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}