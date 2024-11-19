import 'package:flutter/material.dart';
import 'package:shoping/shared/styles/colors.dart';
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
void navigateTo(context,widget)=>Navigator.push(context, widget);

Widget titleText ({required String title,context}) => Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );

Widget bodyText ({required String body,context})=> Text(body,style: Theme.of(context).textTheme.bodyMedium,);

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