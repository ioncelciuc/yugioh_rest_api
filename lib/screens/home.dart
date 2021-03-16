import 'package:flutter/material.dart';
import 'package:yugioh_rest_api/screens/archetypes_page.dart';
import 'package:yugioh_rest_api/screens/load_data.dart';

class Home extends StatefulWidget {
  static const String id = 'Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    LoadData(),
    ArchetypesPage(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Card Database',
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: 'Archetypes',
            icon: Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}
