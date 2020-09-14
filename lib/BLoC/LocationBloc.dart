import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';

class LocationBloc extends Bloc<Location, Location> {
  Location _location = Location(id: 3, title: 'asdd', type: 'pop');

  LocationBloc(this._location) : super(_location);

  Location get selectedLocation => _location;

  @override
  Location get initialState => selectedLocation;

  @override
  Stream<Location> mapEventToState(Location location) async* {
    setLocation(location);
    yield state.copyWith(id: location.id, type: location.type, title: location.title);
  }

  Location setLocation(Location location) {
    _location = location;
    return selectedLocation;
  }
}
