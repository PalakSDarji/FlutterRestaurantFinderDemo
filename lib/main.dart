import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationBloc.dart';
import 'package:my_bloc_flutter_app/UI/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = LocationBloc(AskLocationState());
    //fetch location first if available
    locationBloc.add(GetLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => locationBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    locationBloc.close();
  }
}
