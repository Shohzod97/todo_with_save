import 'package:flutter/material.dart';

Widget viewInventory(BuildContext context) => Padding(      //Кнопка "Посмотреть инвентарь"
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: RaisedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/inventory');
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
              ],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
            alignment: Alignment.center,
            child: const Text(
              'Посмотреть инвентарь',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
