import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../hero_page/name_hero.dart';
import '../hero_page/image_hero.dart';
import '../hero_page/build_icons.dart';
import '../hero_page/veiw_inventory.dart';

String name = "Аватар";

class HeroPage extends StatefulWidget {
  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {

  @override
  Widget build(BuildContext context) {                  //Страница с героем

    final data = Provider.of<Data>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text("Герой"),
        ),
        body: Container(
          child: _buildStruct(data),
        ));
  }

  Widget _buildStruct(data) => Container(
        color: Colors.white,
        child: ListView(children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [                     //см. папку hero_page
                ImageHero(),
                nameHero(name),               //имя
                buildIcons(context),          //характеристики с иконками
                SizedBox(height: 25),
                viewInventory(context),       //посмотреть инвентарь
              ],
            ),
          ),
        ]),
      );
}
