import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../store_page/item_card.dart';

class StorePage extends StatelessWidget {         // Магазин
  @override
  Widget build(BuildContext context) {
    final rewardData = context.watch<RewardsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Вознаграждения"),
      ),
      backgroundColor: Colors.amberAccent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 5, bottom: 8),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: rewardData.items.length,
              itemBuilder: (context, int index) => ChangeNotifierProvider.value(
                    value: rewardData.items[index],
                    child: ItemCard(),                                            //Карточка награды
                  )),
        ),
      ),
    );
  }
}
