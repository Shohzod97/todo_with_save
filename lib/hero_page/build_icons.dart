import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';

Widget buildIcons(BuildContext context) => Card(        //характеристики героя
      child: Container(
        padding: const EdgeInsets.all(10),
        child: _buildRowOfIcons(context),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(5),
    );


Widget _buildRowOfIcons(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIcon("Опыт: ${context.watch<Data>().getEx}", Icons.star),

        _buildIcon("Деньги:  ${context.watch<Data>().getMoney}",
            Icons.attach_money),

        _buildIcon("Уровень: ${context.watch<Data>().level()}", Icons.star),
      ],
    );

Widget _buildIcon(label, icon) => Column(
      children: [
        Icon(icon, color: Colors.black),
        Container(
          child: Text(label,
              style: TextStyle(
                color:  Colors.deepOrangeAccent,
                fontWeight: FontWeight.w400,
              )),
        )
      ],
    );
