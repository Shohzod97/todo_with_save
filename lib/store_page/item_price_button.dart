import 'package:flutter/material.dart';

import 'buy_button.dart';

Widget itemPriceButton(reward, data, inventory, BuildContext context) => Row(   //название, цена и "Купить"
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _priceText(reward),                                                     //цена
        Icon(
          Icons.attach_money,
          size: 18,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        buyButton(reward, data, inventory, context),                           //кнопка"Купить"
        SizedBox(width: 5),
      ],
    );

Widget _priceText(reward) => Text('${reward.price}',
    style: TextStyle(
        fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500));
