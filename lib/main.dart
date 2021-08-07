import 'package:flutter/material.dart';
import 'package:flutter_myapp_demo/pages/inventory_page.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'pages/home_page.dart';
import 'pages/hero_page.dart';
import 'pages/todo_page.dart';
import 'pages/store_page.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(                                  //Данные в data.dart
        providers: [
          ChangeNotifierProvider<Data>(                   //Общие данные (деньги, опыт, уровень и др.)
              create: (context) => Data()),
          ChangeNotifierProvider<TasksProvider>(          //Для заданий todo_page
              create: (context) => TasksProvider()),
          ChangeNotifierProvider<RewardsProvider>(        //Для магазина наград на store_page
            create: (context) => RewardsProvider(),
          ),
          ChangeNotifierProvider<InventoryProvider>(      //Для инвентаря на inventory_page
            create: (context) => InventoryProvider(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.deepOrangeAccent,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => Home(),                     //общая страница
            '/hero': (context) => HeroPage(),             //Герой
            '/todo': (context) => TodoPage(),             //Задания
            '/store': (context) => StorePage(),           //Магазин наград
            '/inventory': (context) => InventoryPage(),   //Инвентарь
          },
        ));
  }
}
