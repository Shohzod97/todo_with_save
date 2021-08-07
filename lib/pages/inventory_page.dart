import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../inventory_page/show_go_store.dart';
import '../inventory_page/invent_list.dart';

class InventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inventoryData = context.watch<InventoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Инвентарь'),
      ),
      body: inventoryData.inventoryItems.isEmpty
          ? showGoStore(context)                            //кнопка перехода в Магазин
          : InventoryList(inventoryData: inventoryData),    //список приобретенных вознаграждений
    );
  }
}
