import 'package:flutter/material.dart';
import 'package:yugioh_rest_api/screens/load_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoadData.id,
      routes: {
        LoadData.id: (context) => LoadData(),
      },
    );
  }
}
