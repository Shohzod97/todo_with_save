import 'package:flutter/material.dart';

Widget nameHero(name) {               //просто отображение имени героя
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      child: Text(
          name,
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black),
        ),
    ),
  );
}
