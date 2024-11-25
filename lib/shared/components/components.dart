import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping/shared/styles/colors.dart';
import '../../layouts/shop_layout/cubit_home/cubit_home.dart';
import '../../models/boarding_model.dart';

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(model.image),
        )),
        SizedBox(
          height: 15,
        ),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Widget titleText ({required String title,context}) => Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );

Widget bodyText ({required String body, context})=>
    Text(body,style: Theme.of(context).textTheme.bodyMedium,);

Widget buttonText ({required String text,function,context})=> TextButton(onPressed: function,
        child: Text(
            text.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            color: defaultColor,
          ),
        ),
    );

Widget defaultButton({
  double width = double.infinity,
  double radius = 3,
  required VoidCallback function,
  required String text,
}) => Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: defaultColor,
      ),
    );

Widget editTextForm({
  required TextEditingController controller,
  TextInputType? keyboardType,
  required String label,
  bool isPassword = false,
  required IconData prefixIcon,
  IconData? suffix,
  final VoidCallback? suffixIconPressed,
  final ValueChanged<String>? onSubmit,
  final ValueSetter<String>? onChange,
  final GestureTapCallback? onTap,
  required FormFieldValidator<String>? validator,
  bool isClickable = true,
}) => TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed: suffixIconPressed,
          icon: Icon(suffix),
        ),
        //border: OutlineInputBorder(),
      ),
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      enabled: isClickable,
    );

void showToast({
  required String? message,
  required ToastStates state,
})=>
    Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

//enum
enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){

  Color color;

  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(
    vertical: 20.0,
    horizontal: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

//Build List Product Item
Widget buildProductItem(model, context, {bool isOldPrice = true})=>Padding(
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
                  model!.image ?? '',
                ),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if (model.discount != 0 && isOldPrice)
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
                model.name ?? '',
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
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0 && isOldPrice)
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
                    onPressed: () {
                      HomeCubit.get(context).changeFavorites(model.id);
                      print(model.id);
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
