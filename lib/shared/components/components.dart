import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
