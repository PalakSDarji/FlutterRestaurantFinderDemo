import 'package:flutter/material.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationProvider.dart';
import 'package:my_bloc_flutter_app/BLoC/RestaurantProvider.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final selectedRestaurant = Provider.of<RestaurantProvider>(context, listen: false).selectedRestaurant;

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: FutureBuilder<Location>(
          future: locationProvider.getLocationFromSharedPref(),
          builder: (context, snapshot) {
            print("snap $snapshot");
            return Row(
              children: [
                Container(
                  child: snapshot.hasData
                      ? Column(
                          children: [
                            Text('Selected Location:'),
                            Text('${snapshot.data.id}'),
                            Text('${snapshot.data.title}'),
                            Text('${snapshot.data.type}'),
                            Text('${selectedRestaurant.id}, ${selectedRestaurant.name}'),
                          ],
                        )
                      : Text('No location is selected, Select first!'),
                ),
                RaisedButton(
                  onPressed: () {
                    locationProvider.removeLocation();
                  },
                  child: Text('Clear'),
                )
              ],
            );
          },
        ));
  }
}
