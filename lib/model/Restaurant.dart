import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String url;
  final String currency;
  final String thumbUrl;
  final String imageUrl;
  final String cuisines;
  final String address;
  final Rating rating;
  final int priceRange;

  @override
  String toString() {
    return 'Restaurant{id: $id, name: $name, url: $url, currency: $currency, thumbUrl: $thumbUrl, imageUrl: $imageUrl, cuisines: $cuisines, address: $address, rating: $rating, priceRange: $priceRange}';
  }

  @override
  List<Object> get props => [
        id,
        name,
        url,
        currency,
        thumbUrl,
        imageUrl,
        cuisines,
        address,
        rating,
        priceRange
      ];

  Restaurant.fromJson(json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        thumbUrl = json['thumb'],
        imageUrl = json['featured_image'],
        priceRange = json['price_range'],
        currency = json['currency'],
        cuisines = json['cuisines'],
        address = json['location']['address'],
        rating = Rating.fromJson(json['user_rating']);
}

class Rating extends Equatable {
  final String text;
  final String average;

  Rating.fromJson(Map json)
      : text = json['rating_text'].toString(),
        average = json['aggregate_rating'].toString();

  @override
  String toString() {
    return 'Rating{text: $text, average: $average}';
  }

  @override
  List<Object> get props => [text, average];
}
