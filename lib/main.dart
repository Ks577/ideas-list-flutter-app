import 'package:flutter/material.dart';
import 'package:ideas_list_flutter/screens/home_screen.dart';
import 'package:ideas_list_flutter/services/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: IdeasScreen(),
    );
  }
}
