import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import 'invent_item.dart';

class InventoryList extends StatelessWidget {              //список приобретенных вознаграждений
  final inventoryData;

  InventoryList({Key? key, required this.inventoryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemKey = inventoryData.inventoryItems.keys.toList();


    final inventoryProvider =
        Provider.of<InventoryProvider>(context, listen: false);

    return Container(
      child: ListView.builder(
          padding: const EdgeInsets.all(15.0),
          itemCount: inventoryData.inventoryItemsCount,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(itemKey[index]),
              background: _swipeBackground(                               //свайп влево - удалить
                  Colors.red, Icons.delete_forever, Alignment.centerRight),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                inventoryProvider.deleteItem(itemKey[index]);
              },
              child: InventoryItem(                           //карточка вознаграждения
                inventoryData: inventoryData,
                inventoryProvider: inventoryProvider,
                index: index,
              ),
            );
          }),
    );
  }

  Widget _swipeBackground(color, icon, align) => Container(
        alignment: align,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      );     //задний фон при свайпе
  //этот объект 2 раза поторяется в проекте, но больше нет повторяющихся, поэтому удобнее не создавать отдельную папку для него
}
