import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/utils/configure.dart' as configure;

String _apiKeyP = "14316831-b526440549b4ee06a100d780d";
String _apiKeyW = "75816b81c0e1be6fe46cdab220700cea";

WeatherData _parseWeatherCityInformation(String responseBody) {
  WeatherData _weather;
  try {
    //Future.delayed(Duration(seconds: 3), () {
      var data = json.decode(responseBody);
      //print(data);
      _weather = WeatherData.fromJson(data);
    //});
  } catch (e) {
    print('Excepcion \n $e');
  }
  return _weather;
}

Future<WeatherData> getWeatherCityInformation(
        {@required String city, @required String code}) async =>
    configure.checkInternet().then((bool conected) async {
      if (conected) {
        try {
          var res = await http.get(
            Uri.encodeFull(
                "https://api.openweathermap.org/data/2.5/weather?q=$city,$code&appid=$_apiKeyW"),
          );
          return compute(
              _parseWeatherCityInformation, utf8.decode(res.bodyBytes));
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
    });

String _parsePhoto(String responseBody) {
  String _photo;
  try {
    var data = json.decode(responseBody);
    //print(data);
    _photo = data['hits'][0]['largeImageURL'].toString();
  } catch (e) {
    print('Excepcion \n $e');
  }
  return _photo;
}

Future<String> getImageNetwork({String content = "city"}) async =>
    configure.checkInternet().then((bool conected) async {
      if (conected) {
        try {
          var res = await http.get(
            Uri.encodeFull(
                "https://pixabay.com/api/?key=$_apiKeyP&q=$content&image_type=photo&per_page=3"),
          );
          //print(res.statusCode);
          return compute(_parsePhoto, utf8.decode(res.bodyBytes));
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
    });
