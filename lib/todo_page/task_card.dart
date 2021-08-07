import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_task.dart';

class TaskCard extends StatelessWidget {         //Карточка задания в списке
  final taskData;
  final index;

  const TaskCard({Key? key, required this.taskData, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentItem = taskData.taskItems.values.toList()[index];

    return Card(
      elevation: 10,
      shadowColor: Colors.black87,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: Text(currentItem.title),                                 //название задания
        subtitle: Text("Опыт: ${currentItem.exp}"),                     //опыт
        leading: editTask(context, currentItem, index),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${currentItem.money}",                                 //награда
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.attach_money,
              color: Colors.grey[600],
            )
          ],
        ),
      ),
    );
  }
}
