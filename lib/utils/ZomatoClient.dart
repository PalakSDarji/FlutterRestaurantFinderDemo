import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_bloc_flutter_app/model/Location.dart';
import 'package:my_bloc_flutter_app/model/Restaurant.dart';

class ZomatoClient {
  final _apiKey = "d42cd3dba86d50521195e265d5faebf1";
  final _host = 'developers.zomato.com';
  final _contextRoot = 'api/v2.1';

  Future<List<Location>> fetchLocations(String query) async {
    final results = await request(
        path: 'locations', params: {'query': query, 'count': '10'});
    print("fetchLocations results : $results");
    final suggestions = results['location_suggestions'];
    return suggestions
        .map<Location>((json) => Location.fromJson(json))
        .toList(growable: false);
  }

  Future<List<Restaurant>> fetchRestaurants(
      Location location, String query) async {
    final results = await request(path: 'search', params: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'q': query,
      'count': '10'
    });

    final restaurants = results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    print("Restaurants list : $restaurants");
    return restaurants;
  }

  Future<Map> request(
      {@required String path, Map<String, String> params}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', params);
    final results = await http.get(uri, headers: _headers);
    return json.decode(results.body);
  }

  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': _apiKey};
}
