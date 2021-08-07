import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';

String title = "";
num money = 0;
num exp = 0;

Widget editTask(BuildContext context, currentItem, index) => IconButton(         //редактирование задания
    icon: Icon(
      Icons.edit,
      color: Colors.deepOrangeAccent,
    ),
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _editForm(currentItem, context, index);
          });
    });

Widget _editForm(currentItem, BuildContext context, index) => AlertDialog(     //окно редактирования
      scrollable: true,
      title: Text('Редактирование'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              _buildTextField(currentItem),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              context.read<TasksProvider>().editTask(             //обновление данных задания
                  task: currentItem.title,
                  title: title,
                  money: money,
                  exp: exp,
                index: index
              );

              Navigator.of(context)
                  .pop();
            },
            child: Text("Edit"))
      ],
    );

Widget _buildTextField(currentItem) => Column(                //форма редактирования
      children: [
        buildField(currentItem.title, "Задание", Icon(Icons.title)),
        buildField(currentItem.exp, "Опыт", Icon(Icons.star)),
        buildField(currentItem.money, "Награда", Icon(Icons.attach_money)),
      ],
    );

Widget buildField(currentItem, label, icon) => TextFormField(
      initialValue: label == "Задание" ? currentItem : "${currentItem}",
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
