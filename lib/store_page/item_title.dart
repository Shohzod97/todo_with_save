import 'package:flutter/material.dart';

Widget itemTitle(reward) => Container(          //название награды
      child: Text(
        '${reward.title}',
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      margin: const EdgeInsets.only(left: 20),
    );
