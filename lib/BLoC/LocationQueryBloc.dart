import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:my_bloc_flutter_app/utils/ZomatoClient.dart';

class LocationQueryBloc extends Bloc<LocationQueryEvent, List<Location>> {
  final client = ZomatoClient();

  LocationQueryBloc() : super(null);

  @override
  Stream<List<Location>> mapEventToState(LocationQueryEvent event) async* {
    if (event is FetchLocationEvent) {
      print("fetchLocations in map");
      yield await findLocationForQuery(event.query);
    }
  }

  Future<List<Location>> findLocationForQuery(String query) async {
    return query.isEmpty ? [] : await client.fetchLocations(query);
  }
}

abstract class LocationQueryEvent {}

class FetchLocationEvent extends LocationQueryEvent {
  String query;

  FetchLocationEvent(this.query);
}
