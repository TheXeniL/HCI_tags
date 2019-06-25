class PlaceResponse {
  final List<Place> places;

  PlaceResponse({this.places});

  PlaceResponse.fromJson(Map<String, dynamic> json)
      : places =
            (json["places"] as List)
            .map((i) => new Place
            .fromJson(i))
            .toList();
}

class Place {
  final String id;
  final String name;
  final String description;
  final String latitude;
  final String longtitude;
  final String image;
  final Map<String, int> tags;

  Place(
      {this.id,
      this.name,
      this.description,
      this.latitude,
      this.longtitude,
      this.image,
      this.tags});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        latitude: json['latitude'],
        longtitude: json['longitude'],
        image: json['img_link'],
        tags: json['tags']);
  }
}
