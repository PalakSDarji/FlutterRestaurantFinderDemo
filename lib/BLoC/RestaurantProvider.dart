import 'package:flutter/cupertino.dart';
import 'package:my_bloc_flutter_app/model/Restaurant.dart';
import 'package:state_notifier/state_notifier.dart';

class RestaurantProvider{

  Restaurant _selectedRestaurant;
  Restaurant get selectedRestaurant => _selectedRestaurant;

  void setSelectedRestaurant(Restaurant restaurant){
    _selectedRestaurant = restaurant;
  }
}