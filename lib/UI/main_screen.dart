import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationBloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationProvider.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationQueryBloc.dart';
import 'package:my_bloc_flutter_app/UI/location_screen.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final locationProvider = Provider.of<LocationProvider>(context);
    return FutureBuilder<Location>(
      future: locationProvider.getLocationFromSharedPref(),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? Container(
                child: LocationScreen(),
              )
            : Container(
                child: Text('Navigate to search restaurant screen'),
              );
      },
    );
  }
}
