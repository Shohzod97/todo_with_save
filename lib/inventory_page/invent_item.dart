import 'package:flutter/material.dart';

import 'invent_item_button.dart';
import 'invent_item_image.dart';

class InventoryItem extends StatelessWidget {           //карточка вознаграждения
  final inventoryProvider;
  final inventoryData;
  final index;

  const InventoryItem(
      {Key? key,
      required this.inventoryData,
      required this.inventoryProvider,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemValue = inventoryData.inventoryItems.values.toList()[index];
    final itemKey = inventoryData.inventoryItems.keys.toList()[index];

    return Container(
      child: ListTile(
        leading: itemImage(itemValue),                      //фото
        title: Text(itemValue.title),                       //наименование
        subtitle: Text('Штук: ${itemValue.number}'),        //кол-во
        trailing: buttonWaste(inventoryProvider, itemValue), //кнопка "Потратить"
      ),
    );
  }
}
