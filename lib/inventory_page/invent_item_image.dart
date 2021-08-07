import 'package:flutter/material.dart';

Widget itemImage(itemValue) => Container(           //фото награжды
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(itemValue.img),
          fit: BoxFit.cover,
        ),
      ),
    );
