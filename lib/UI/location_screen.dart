import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationBloc.dart';
import 'package:my_bloc_flutter_app/BLoC/LocationQueryBloc.dart';
import 'package:my_bloc_flutter_app/BLoC/RestaurantQueryBloc.dart';
import 'package:my_bloc_flutter_app/UI/restaurant_search_screen.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Where do you want to eat?'),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (t) {
                        context.bloc<LocationQueryBloc>().add(
                              FetchLocationEvent(searchTextController.text),
                            );
                      },
                      controller: searchTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter a Location',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () {
                      context.bloc<LocationQueryBloc>().add(
                            FetchLocationEvent(searchTextController.text),
                          );
                    },
                    child: Text('Search'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            color: Colors.black45,
            height: 1,
          ),
          Expanded(
            child: _buildResults(context),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    return BlocBuilder<LocationQueryBloc, List<Location>>(
      builder: (context, locations) {
        return Container(
          child: (locations != null && locations.isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.bloc<LocationBloc>().add(locations[index]);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => RestaurantQueryBloc(locations[index]),
                                child: RestaurantSearchScreen(),
                              );
                            }
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [Text('${locations[index].title}')],
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Text('Enter a location'),
                ),
        );
      },
    );
  }
}
