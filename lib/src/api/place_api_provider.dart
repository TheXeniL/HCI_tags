import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:map_tags/src/models/place.dart';

class PlaceApiProvider {
  BaseOptions options = new BaseOptions(
    baseUrl: "http://35.234.77.26:5000/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  getAllPlaces() async {
    Dio dio = new Dio(options);
    try {
      Response response = await dio.get('reviewSystem/places/all');
      Map<String, dynamic> jsonData = json.decode(response.data.toString());
      var placeResponse = PlaceResponse.fromJson(jsonData);
      return placeResponse;
    } catch (error) {
      print("Exception occured: $error");
    }
  }
}
