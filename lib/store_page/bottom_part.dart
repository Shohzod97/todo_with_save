import 'package:flutter/material.dart';

import 'item_price_button.dart';
import 'item_title.dart';

Widget bottomPart(reward, data, inventory, BuildContext context) =>
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          itemTitle(reward),                                    //название
          itemPriceButton(reward, data, inventory, context),    //цена и "Купить"
        ],
      ),
    );
