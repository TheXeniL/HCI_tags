class PlaceResponse {
  final List<Place> places;

  PlaceResponse({this.places});

  PlaceResponse.fromJson(Map<String, dynamic> json)
      : places = (json["places"] as List)
            .map((value) => new Place.fromJson(value))
            .toList();
}

class Place {
  final String id;
  final String name;
  final String description;
  final String latitude;
  final String longtitude;
  final String image;
  final Map<String, dynamic> tags;

  Place(
      {this.id,
      this.name,
      this.description,
      this.latitude,
      this.longtitude,
      this.image, 
      this.tags});

  Place.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        description = json['description'],
        latitude = json['latitude'],
        longtitude = json['longitude'],
        image = json['img_link'],
        tags = json['tags'];}
