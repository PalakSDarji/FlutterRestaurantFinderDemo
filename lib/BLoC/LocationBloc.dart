import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(LocationState initialState) : super(initialState);

  /*@override
  Stream<LocationState> mapEventToState(Location location) async* {
    setLocation(location);
    yield state.copyWith(
        id: location.id, type: location.type, title: location.title);
  }*/

  void getLocation() async {
    final pref = await SharedPreferences.getInstance();
    Location savedLocation = jsonDecode(pref.get("location"));
    print("savedLocation : $savedLocation");
  }

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is GetLocationEvent) {
      final pref = await SharedPreferences.getInstance();
      Location savedLocation = jsonDecode(pref.get("location"));

      getLocation();

      if (savedLocation == null) {
        yield AskLocationState();
      } else {
        yield GotLocationState(savedLocation);
      }
    }
    else if(event is SetLocationEvent){
      final pref = await SharedPreferences.getInstance();
      pref.setString("location", jsonEncode(event.location));

      getLocation();
    }
  }
}

@immutable
abstract class LocationState extends Equatable {}

class AskLocationState extends LocationState {
  @override
  List<Object> get props => [];
}

class GotLocationState extends LocationState {
  final Location location;

  GotLocationState(this.location);

  @override
  List<Object> get props => [location];
}

@immutable
abstract class LocationEvent extends Equatable {}

class GetLocationEvent extends LocationEvent {
  @override
  List<Object> get props => [];
}

class SetLocationEvent extends LocationEvent {
  final Location location;

  SetLocationEvent(this.location);

  @override
  List<Object> get props => [location];
}

class LocationStoredEvent extends LocationEvent{
  @override
  List<Object> get props => [];

}
