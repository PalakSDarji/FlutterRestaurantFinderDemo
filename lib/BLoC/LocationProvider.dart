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
    Location savedLocation = jsonDecode(pref.get("location"));
    print("savedLocation : $savedLocation");
    return savedLocation;
  }

  void setLocationToSharedPref(Location location) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("location", jsonEncode(location));
  }

  void setLocation(Location location){
    setLocationToSharedPref(location);
    notifyListeners();
  }
}