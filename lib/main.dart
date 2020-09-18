import 'package:flutter/material.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationProvider.dart';
import 'package:my_bloc_flutter_app/BLoC/RestaurantProvider.dart';
import 'package:my_bloc_flutter_app/UI/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Provider<RestaurantProvider>(
      create: (context) => RestaurantProvider(),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => LocationProvider(),
        builder: (context, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainScreen(),
        ),
      ),
    );
  }
}
