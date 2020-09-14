import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationBloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationQueryBloc.dart';
import 'package:my_bloc_flutter_app/UI/location_screen.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider<LocationBloc>(
      create: (context) => context.bloc<LocationBloc>(),
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (BuildContext context, LocationState locationState) {
          if (locationState is AskLocationState) {
            return Container(
              child: BlocProvider(
                create: (BuildContext context) => LocationQueryBloc(),
                child: LocationScreen(),
              ),
            );
          } else if (locationState is GotLocationState) {
            return Container(
              child: Text('Navigate to search restaurant screen'),
            );
          }
          return null;
        },
      ),
    );
  }
}
