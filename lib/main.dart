import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:yugioh_rest_api/screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return ThemeManager(
      defaultBrightnessPreference: BrightnessPreference.light,
      data: (brightness) => ThemeData(
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, themeData) => MaterialApp(
        theme: themeData,
        initialRoute: Home.id,
        routes: {
          Home.id: (context) => Home(),
        },
      ),
    );
  }
}
