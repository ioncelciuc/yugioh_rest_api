import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yugioh_rest_api/screens/archetypes_page.dart';
import 'package:yugioh_rest_api/screens/load_data.dart';

class Home extends StatefulWidget {
  static const String id = 'Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          LoadData(link: env['CARD_INFO']),
          ArchetypesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int value) {
          setState(() {
            currentIndex = value;
            controller.jumpToPage(currentIndex);
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
