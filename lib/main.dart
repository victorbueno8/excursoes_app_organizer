import 'package:flutter/material.dart';
import 'package:excursoes_app_organizer/util/dbhelper.dart';
import 'package:excursoes_app_organizer/model/excursion.dart';
import 'package:excursoes_app_organizer/screens/excursionList.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excursões App',
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext formContext) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Minhas Excursões"),
      ),
      body: ExcursionList()
    );
  }
}