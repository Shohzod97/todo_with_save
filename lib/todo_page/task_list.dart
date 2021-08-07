import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import 'task_card.dart';

class TaskList extends StatelessWidget {                        //отображение списка
  final taskData;

  TaskList({Key? key, required this.taskData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<Data>(context, listen: false);
    final taskProvider = Provider.of<TasksProvider>(context, listen: false);

    var itemValue = taskData.taskItems.values.toList();
    var itemKey = taskData.taskItems.keys.toList();

    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: taskData.taskItemsCount,
        itemBuilder: (context, index) {
          return Column(children: [
            Dismissible(
                key: ValueKey(itemKey[index]),
                background: _swipeBackground(Colors.green,
                    Icons.check_circle_sharp, Alignment.centerLeft),
                secondaryBackground: _swipeBackground(
                    Colors.red, Icons.delete_forever, Alignment.centerRight),
                child: TaskCard(                                                 //карточка задания
                  taskData: taskData,
                  index: index,
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {               //свайп вправо
                    dataProvider.getExpMoney(
                        itemValue[index].exp, itemValue[index].money);          //доб. денег и опыта
                    taskProvider.deleteTask(itemKey[index], index);                    //удаление из списка
                    dataProvider.saveData();
                  }
                  if (direction == DismissDirection.endToStart)
                    taskProvider.deleteTask(itemKey[index], index);                    //влево - просто удаление
                }),
          ]);
        });
  }

  Widget _swipeBackground(color, icon, align) => Container(                   //задний фон при свайпе
        alignment: align,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      );
}
