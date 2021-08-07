import 'package:flutter/material.dart';
import 'package:flutter_myapp_demo/pages/hero_page.dart';
import 'package:flutter_myapp_demo/pages/store_page.dart';
import 'package:flutter_myapp_demo/pages/todo_page.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class Home extends StatefulWidget {
  //Общая страница с навигацией
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {                                            //Загружаем сохраненные данные

    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<Data>().donwloadData();
      context.read<TasksProvider>().downloadTasks();
      context.read<InventoryProvider>().downloadInventory();
      print("Загрузили в Home");
    });
  }

  int _currentIndex = 0;

  final tabs = [
    Center(child: HeroPage()),
    Center(child: TodoPage()),
    Center(child: StorePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xC8131313),
        selectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _currentIndex,
        iconSize: 25,
        unselectedFontSize: 14,
        selectedFontSize: 16,
        //unselectedLabelStyle: TextStyle(color: Colors.white),
        unselectedItemColor: Colors.white,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Hero",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Store",
          ),
        ],
      ),
    );
  }
}
