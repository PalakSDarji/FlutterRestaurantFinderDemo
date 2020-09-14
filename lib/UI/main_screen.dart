import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationBloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationQueryBloc.dart';
import 'package:my_bloc_flutter_app/UI/location_screen.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, Location>(
      builder: (BuildContext context, Location state) {
        return Container(
          child: state == null
              ? BlocProvider(
                  create: (BuildContext context) => LocationQueryBloc(),
                  child: LocationScreen(),
                )
              : Text('Navigate to search restaurant screen'),
        );
      },
    );
  }
}
