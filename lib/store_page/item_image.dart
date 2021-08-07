import 'package:flutter/material.dart';

Widget itemImage(reward) => Container(            //фото награды
      height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(reward.img),
            fit: BoxFit.cover,
          )),
    );
