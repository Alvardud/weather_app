import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/ui/pages/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 28.0,
            color: Colors.black
          ),
          subtitle: TextStyle(
            fontSize: 16.0,
            color: Colors.black45
          )
        ),
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
