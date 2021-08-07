import 'package:flutter/material.dart';

Widget buttonWaste(inventoryProvider, itemValue) => ElevatedButton(    //кнопка "Потратить"
    onPressed: () {
      inventoryProvider.updateItemsSubOne(itemValue.title);                  //удалит из списка
    },
    child: Text("Потратить"),
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xC8131313)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(color: Colors.black))),
    ));
