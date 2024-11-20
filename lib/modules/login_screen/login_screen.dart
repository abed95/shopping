import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping/layouts/shop_layout/shop_home_layout.dart';
import 'package:shoping/modules/login_screen/cubit_login/cubit_login.dart';
import 'package:shoping/modules/login_screen/cubit_login/states_login.dart';
import 'package:shoping/modules/register_screen/register_screen.dart';
import 'package:shoping/shared/components/components.dart';
import 'package:shoping/shared/networks/local/cache_helper.dart';
import 'package:shoping/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,state){
        if(state is ShopLoginSuccessState){
          if(state.loginModel?.status!=null)
          {
            print({'The state is :',state});
            print({'The Status of request is :',state.loginModel?.status});
            CacheHelper.saveData(
                key: 'token',
                value: state.loginModel?.data?.token,).then((onValue){
                  navigateAndFinish(context, ShopHomeLayout(),);
                  showToast(message: state.loginModel?.message, state: ToastStates.SUCCESS);
            }).catchError((onError){
              print({'The error is :',onError});
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
                        titleText(title: 'LOGIN', context: context),
                        bodyText(
                            body: 'Login now to browse an amazing offers',
                            context: context),
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
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          prefixIcon: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixIconPressed: () {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validator: (String? value){
                            if (value!.isEmpty) {
                              return 'You must enter password';
                            }
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButton(
                            function: () {
                              print('inside Button');
                              FocusScope.of(context).unfocus();
                              if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                              );
                            }
                              },
                            text: 'login',
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator(color: defaultColor,),),
                        ),
                        Row(
                          children: [
                            bodyText(body: 'Don\'t have an account?', context: context),
                            buttonText(text: 'register now', context: context,function: (){
                              print('register button taped');
                              navigateTo(context, RegisterScreen());
                            }),
                          ],
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
