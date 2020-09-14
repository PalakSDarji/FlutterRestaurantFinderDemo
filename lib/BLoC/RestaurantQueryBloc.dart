import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:my_bloc_flutter_app/model/Restaurant.dart';
import 'package:my_bloc_flutter_app/utils/ZomatoClient.dart';

class RestaurantQueryBloc extends Bloc<RestaurantQueryEvent, List<Restaurant>>{

  final location;
  final client = ZomatoClient();

  RestaurantQueryBloc(this.location) : super(null);

  @override
  Stream<List<Restaurant>> mapEventToState(RestaurantQueryEvent event) async* {
    if(event is FetchRestaurantEvent){
      final list = await findRestaurantsForQuery(location, event.query);
      yield list;
      print("yield list $list ");
    }
  }

  Future<List<Restaurant>> findRestaurantsForQuery(Location location, String query) async {
    return query.isEmpty ? [] : await client.fetchRestaurants(location, query);
  }
}

abstract class RestaurantQueryEvent {}

class FetchRestaurantEvent extends RestaurantQueryEvent {
  String query;
  FetchRestaurantEvent(this.query);
}
