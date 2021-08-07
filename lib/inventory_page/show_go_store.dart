import 'package:flutter/material.dart';

Widget showGoStore(BuildContext context) => Card(   //кнопка перехода в магазин
      elevation: 5.0,
      margin: const EdgeInsets.all(30.0),
      child: Container(
        height: 100,
        width: double.infinity,
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/store');
          },
          child: Text("Магазин", style: TextStyle(color: Colors.white)),
          color: Colors.deepOrange,
        ), //Text('Инвентарь пуст', ),
      ),
    );
