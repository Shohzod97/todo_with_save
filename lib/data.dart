import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Data with ChangeNotifier {
  //путь для фото
  String _appDocPath = '';
  String get getPath => _appDocPath;
  void getApplicationDirectoryPath() async {
    if (_appDocPath == '') {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      _appDocPath = appDocDir.path;
      print("Взятый путь: $_appDocPath");
    }
  }

  //exp, money, level
  num _money = 0;
  num _countEx = 0;
  int _level = 0;

  num get getEx => _countEx;
  num get getMoney => _money;
  int level() => _level = _countEx ~/ 1000;

  void getExpMoney(num newExp, num newMoney) {
    _countEx += newExp;
    _money += newMoney;
    notifyListeners();
  }

  void buy(num cost) => _money -= cost;

  void saveData() async {
    var box = await Hive.openBox<dynamic>('DataBox');
    await box.put('money', _money);
    await box.put('countEx', _countEx);
    await box.put('level', _level);

    print("Сохранено");
    await box.close();
  }

  void donwloadData() async {
    var box = await Hive.openBox<dynamic>('DataBox');

    if (box.isNotEmpty) {
      _money = box.get('money') as num;
      _countEx = box.get('countEx') as num;
      _level = box.get('level') as int;
    }
    await box.close();
    notifyListeners();
  }
}

// Задания
class Task {
  final String title;
  final num money;
  final num exp;

  Task({
    required this.title,
    required this.money,
    required this.exp,
  });

  @override
  String toString() => "title: $title, money: $money, exp: $exp";
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final typeId = 0;

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.title);
    writer.write(obj.money);
    writer.write(obj.exp);
  }

  @override
  Task read(BinaryReader reader) {
    final rTitle = reader.readString();
    final rMoney = reader.read();
    final rExp = reader.read();

    return Task(title: rTitle, money: rMoney, exp: rExp);
  }
}

class TasksProvider with ChangeNotifier {
  Map<String, Task> _taskItems = {};

  UnmodifiableMapView<String, Task> get taskItems =>
      UnmodifiableMapView(_taskItems);

  int get taskItemsCount => _taskItems.length;

  void addTask({title, money, exp}) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }

    var box = await Hive.openBox<Task>('TaskBox');
    final xTask = Task(title: title, money: money, exp: exp);

    await box.add(xTask);

    _taskItems.putIfAbsent(title, () => xTask);
    notifyListeners();

    await box.close();
  }

  void downloadTasks() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }

    var box = await Hive.openBox<Task>('TaskBox');

    if (box.isNotEmpty) {
      for (int i = 0; i < box.values.length; i++) {
        var taskFromBox =
            box.getAt(i) ?? Task(title: "error", money: 0, exp: 0);

        _taskItems.putIfAbsent(taskFromBox.title, () => taskFromBox);
        notifyListeners();
      }
    }
    await box.close();
  }

  void deleteTask(title, index) async {
    _taskItems.remove(title);
    var box = await Hive.openBox<Task>('TaskBox');

    box.deleteAt(index);
    await box.close();

    notifyListeners();
  }

  void editTask({task, title, money, exp, index}) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
    var box = await Hive.openBox<Task>('TaskBox');

    var ex = box.getAt(index) ?? Task(title: "error", money: 0, exp: 0);

    final xTask = Task(
      title: title.isEmpty ? ex.title : title,
      money: money == 0 ? ex.money : money,
      exp: exp == 0 ? ex.exp : exp,
    );

    await box.putAt(index, xTask);

    await box.close();

    _taskItems.update(
        task,
        (ex) => Task(
              title: title.isEmpty ? ex.title : title,
              money: money == 0 ? ex.money : money,
              exp: exp == 0 ? ex.exp : exp,
            ));

    notifyListeners();
  }

  void winTask({task, title, money, exp}) {
    _taskItems.update(
        task,
        (ex) => Task(
              title: title.isEmpty ? ex.title : title,
              money: money == 0 ? ex.money : money,
              exp: exp == 0 ? ex.exp : exp,
            ));
    notifyListeners();
  }
}

// Награды

class Reward with ChangeNotifier {
  final String id;
  final String title;
  final num price;
  final String img;

  Reward({
    required this.id,
    required this.title,
    required this.price,
    required this.img,
  });
}

class RewardsProvider with ChangeNotifier {
  List<Reward> _items = [
    Reward(
      id: '1',
      title: 'Кока-кола 0.33 л.',
      price: 50,
      img: "assets/images/cola.png",
    ),
    Reward(
      id: '2',
      title: 'Чипсы 40 г.',
      price: 70,
      img: "assets/images/lays.png",
    ),
    Reward(
      id: '3',
      title: 'Видеоигра 1 час',
      price: 100,
      img: "assets/images/game.png",
    ),
    Reward(
      id: '5',
      title: 'Фильм 2 часа',
      price: 200,
      img: "assets/images/movie.png",
    ),
    Reward(
      id: '4',
      title: 'Что угодно 4 часа',
      price: 400,
      img: "assets/images/any.png",
    ),
  ];

  UnmodifiableListView<Reward> get items => UnmodifiableListView(_items);
}

// Инвентарь
class Inventory {
  final String title;
  final int number;
  final num price;
  final String img;

  Inventory(
      {required this.title,
      required this.number,
      required this.price,
      required this.img});

  @override
  String toString() => "title: $title, кол-во: $number";
}

class InventAdapter extends TypeAdapter<Inventory> {
  @override
  final typeId = 1;

  @override
  void write(BinaryWriter writer, Inventory obj) {
    writer.write(obj.title);
    writer.write(obj.number);
    writer.write(obj.price);
    writer.write(obj.img);
  }

  @override
  Inventory read(BinaryReader reader) {
    final rTitle = reader.read();
    final rNumber = reader.read();
    final rPrice = reader.read();
    final rImg = reader.read();

    return Inventory(title: rTitle, number: rNumber, price: rPrice, img: rImg);
  }
}

class InventoryProvider with ChangeNotifier {
  Map<String, Inventory> _inventoryItems = {};

  UnmodifiableMapView<String, Inventory> get inventoryItems =>
      UnmodifiableMapView(_inventoryItems);

  int get inventoryItemsCount => _inventoryItems.length;

  void addItem({title, price, img}) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(InventAdapter());
    }
    var box = await Hive.openBox<Inventory>('InventBox');

    if (_inventoryItems.containsKey(title)) {
      var myKey = title.codeUnitAt(0).toString();

      var ex = box.get(myKey) ??
          Inventory(
              title: "error",
              number: 0,
              price: 0,
              img: "assets/images/cola.png");

      final xInvent = Inventory(
        title: ex.title,
        price: ex.price,
        img: ex.img,
        number: ex.number + 1,
      );

      await box.put(myKey, xInvent);

      _inventoryItems.update(title, (ex) => xInvent);
    } else {
      final xInvent =
          Inventory(title: title, number: 1, price: price, img: img);

      var myKey = title.codeUnitAt(0).toString();

      await box.put(myKey, xInvent);

      _inventoryItems.putIfAbsent(title, () => xInvent);
    }
    await box.close();

    notifyListeners();
  }

  void updateItemsSubOne(title) async {
    if (_inventoryItems[title]!.number < 2) {
      deleteItem(title);
    } else {
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(InventAdapter());
      }
      var box = await Hive.openBox<Inventory>('InventBox');

      var myKey = title.codeUnitAt(0).toString();
      var ex = box.get(myKey) ??
          Inventory(
              title: "error",
              number: 0,
              price: 0,
              img: "assets/images/cola.png");

      final xInvent = Inventory(
        title: ex.title,
        price: ex.price,
        img: ex.img,
        number: ex.number - 1,
      );

      await box.put(myKey, xInvent);

      _inventoryItems.update(title, (ex) => xInvent);
    }
    notifyListeners();
  }

  void deleteItem(title) async {
    _inventoryItems.remove(title);

    var myKey = title.codeUnitAt(0).toString();

    var box = await Hive.openBox<Inventory>('InventBox');
    await box.delete(myKey);
    await box.close();

    notifyListeners();
  }

  void downloadInventory() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(InventAdapter());
    }

    var box = await Hive.openBox<Inventory>('InventBox');

    if (box.isNotEmpty) {
      for (int i = 0; i < box.values.length; i++) {
        var inventFromBox = box.getAt(i) ??
            Inventory(
                title: "error",
                number: 1,
                price: 1,
                img: "assets/images/cola.png");

        _inventoryItems.putIfAbsent(inventFromBox.title, () => inventFromBox);

        notifyListeners();
      }
    }
    await box.close();
  }
}
