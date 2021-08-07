import 'package:flutter/material.dart';

Widget buyButton(reward, data, inventory, BuildContext context) =>  //кнопка "Купить"
    ElevatedButton(
      child: Text("Купить"),
      onPressed: () {
        if (data.getMoney >= reward.price) {
          data.buy(reward.price);
          data.saveData();

          inventory.addItem(
            title: reward.title,

            price: reward.price,
            img: reward.img,
          );
          _showDialogBox("Куплено", Colors.green, context);             //вспылвающие окна "Куплено" и "Недостаточно денег"
        } else
          _showDialogBox("Недостаточно денег", Colors.red, context);
      },
    );


void _showDialogBox(text, color, BuildContext context) {
  showDialog<void>(
    barrierColor: Color(0x01000000),
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context).pop(true);
      });
      return _infoPopup(text, color);
    },
  );
}          //всплывающее окно

Widget _infoPopup(String text, Color color) => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 62,
            width: double.infinity,
            color: color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: new TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );          //дизайн окна
