import 'package:equatable/equatable.dart';

class Location extends Equatable{
  final int id;
  final String type;
  final String title;

  Location({this.id, this.type, this.title});

  Location.fromJson(Map json)
      : id = json['entity_id'],
        type = json['entity_type'], 
        title = json['title'];

  Location copyWith({
    int id,
    String type,
    String title,
  }) {
    return Location(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  @override
  List<Object> get props => [id,title,type];
}
