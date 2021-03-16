import 'package:flutter/material.dart';
import 'package:yugioh_rest_api/screens/home.dart';
import 'package:yugioh_rest_api/screens/load_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  await DotEnv.load(fileName: '.env');
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
      initialRoute: Home.id,
      routes: {
        Home.id : (context) => Home(),
        LoadData.id: (context) => LoadData(),
      },
    );
  }
}
