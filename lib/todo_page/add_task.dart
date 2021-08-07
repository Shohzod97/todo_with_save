import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';

String title = "";
num money = 0;
num exp = 0;

Widget addTask(BuildContext context) => AlertDialog(          //Окно добавления задания
      actionsPadding: const EdgeInsets.only(right: 20, bottom: 10),
      scrollable: true,
      title: Text(
        'Новое задание',
        textAlign: TextAlign.center,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: _inputForm(),                            //Форма ввода
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              context
                  .read<TasksProvider>()
                  .addTask(title: title, money: money, exp: exp);  //добавление задания в список
              Navigator.of(context).pop();
            },
            child: Text("Добавить"))
      ],
    );

Widget _inputForm() => Column(                           //Форма ввода
      children: [
        _buildField("Задание", Icon(Icons.title)),
        _buildField("Опыт", Icon(Icons.star)),
        _buildField("Награда", Icon(Icons.attach_money)),
      ],
    );


Widget _buildField(label, icon) => TextFormField(       //Поле для ввода
      onChanged: (String value) {
        if (label == "Задание") title = value;
        if (label == "Опыт") exp = num.parse(value);
        if (label == "Награда") money = num.parse(value);
      },
      keyboardType:
          label == "Задание" ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(height: 0.5),
        icon: icon,
      ),
    );
