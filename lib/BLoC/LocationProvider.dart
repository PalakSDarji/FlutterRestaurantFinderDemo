import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider extends ChangeNotifier{
/*
  Location _location;
  Location get location => _location;
  */
  Future<Location> getLocationFromSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    Location savedLocation = Location.fromJson(json.decode(pref.getString("location")));
    return savedLocation;
  }

  void _setLocationToSharedPref(Location location) async {
    final pref = await SharedPreferences.getInstance();
    if(location == null){
      if(pref.containsKey("location")) pref.remove("location");
    }
    else{
      pref.setString("location", json.encode(location));
    }
  }

  void setLocation(Location location){
    _setLocationToSharedPref(location);
    notifyListeners();
  }

  void removeLocation(){
    _setLocationToSharedPref(null);
    notifyListeners();
  }
}