import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/modules/login_screen/cubit_login/cubit_login.dart';
import 'package:shoping/modules/login_screen/cubit_login/states_login.dart';
import 'package:shoping/modules/register_screen/register_screen.dart';
import 'package:shoping/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                              );
                            }
                              },
                            text: 'login',
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          children: [
                            bodyText(body: 'Don\'t have an account?', context: context),
                            buttonText(text: 'register now', context: context,function: (){
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
          );
        },
    ),
    );
  }
}
