import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import 'item_image.dart';
import '../store_page/bottom_part.dart';

class ItemCard extends StatelessWidget {                //Карточка награды


  @override
  Widget build(BuildContext context) {
    final reward = Provider.of<Reward>(context, listen: false);
    final inventory = Provider.of<InventoryProvider>(context, listen: false);
    final data = Provider.of<Data>(context, listen: false);

    return Container(
      width: 150,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          itemImage(reward),                                    //Фото награды
          SizedBox(height: 10),
          bottomPart(reward, data, inventory, context)      //название, цена и "Купить"
        ],
      ),
    );
  }
}
