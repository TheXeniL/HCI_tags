import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:map_tags/src/models/place.dart';

class PlaceApiProvider {
  BaseOptions options = new BaseOptions(
    baseUrl: "http://35.234.111.238:5000/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  getAllPlaces() async {
    Dio dio = new Dio(options);
    try {
      Response response = await dio.get('/reviewSystem/places/all');
      return PlaceResponse.fromJson(response.data);
    } catch (error) {
      print(error);
    }
  }

  Future<PlaceResponse> fetchPlaces() async {
    final response =
        await http.get('http://10.90.138.175:5000/reviewSystem/places/all');
    final responseJson = json.decode(response.body);

    print(responseJson);
    print(PlaceResponse.fromJson(responseJson));

    return PlaceResponse.fromJson(responseJson);
  }
}
