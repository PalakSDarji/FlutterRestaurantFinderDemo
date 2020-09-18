import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_flutter_app/BLoC/RestaurantProvider.dart';
import 'package:my_bloc_flutter_app/BLoC/RestaurantQueryBloc.dart';
import 'package:my_bloc_flutter_app/UI/home_screen.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:my_bloc_flutter_app/model/Restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantSearchScreen extends StatefulWidget {
  final Location location;

  RestaurantSearchScreen(this.location);

  final PageRouteBuilder _homeRoute = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
  );

  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  RestaurantQueryBloc blocRestaurant;

  @override
  void initState() {
    super.initState();
    blocRestaurant = RestaurantQueryBloc(widget.location);
  }

  @override
  void dispose() {
    super.dispose();
    blocRestaurant.close();
  }

  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();

    return BlocProvider<RestaurantQueryBloc>(
      create: (BuildContext context) => blocRestaurant,
      child: Scaffold(
        appBar: AppBar(
          title: Text('What do you want to eat?'),
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
                        /*onChanged: (t) {
                          context.bloc<RestaurantQueryBloc>().add(
                                FetchRestaurantEvent(searchTextController.text),
                              );
                        },*/
                        controller: searchTextController,
                        decoration: InputDecoration(
                          hintText: 'Search restaurant..',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: RaisedButton(
                      onPressed: () {
                        context.bloc<RestaurantQueryBloc>().add(
                              FetchRestaurantEvent(searchTextController.text),
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    return BlocBuilder<RestaurantQueryBloc, List<Restaurant>>(
      cubit: context.bloc<RestaurantQueryBloc>(),
      builder: (context, restaurants) {
        print("print list $restaurants");
        return Container(
          child: (restaurants != null && restaurants.isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        /*Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );*/

                        final selectedRestaurant = Provider.of<RestaurantProvider>(context,listen: false);
                        selectedRestaurant.setSelectedRestaurant(restaurants[index]);

                        Navigator.of(context).pushAndRemoveUntil(
                            widget._homeRoute, (route) => false);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [Text('${restaurants[index].name}')],
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
