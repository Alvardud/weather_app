import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/utils/configure.dart' as configure;

//Api-Key : 75816b81c0e1be6fe46cdab220700cea

WeatherData _parseWeatherCityInformation(String responseBody) {
  WeatherData _weather = WeatherData();
  try {
    var data = json.decode(responseBody);
    //print(data);
    _weather = WeatherData.fromJson(data);
  } catch (e) {
    print('Excepcion \n $e');
  }
  return _weather;
}

Future<WeatherData> getWeatherCityInformation(
        {@required String city, @required String code}) async =>
    configure.checkInternet().then((bool conected) async {
      //TODO: change appid
      if (conected) {
        try {
          var res = await http.get(
            Uri.encodeFull(
                "https://api.openweathermap.org/data/2.5/weather?q=$city,$code&appid=43ea6baaad7663dc17637e22ee6f78f2"),
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

String _parsePhotos(String responseBody) {
  String photo = "prueba";
  try {
    var data = json.decode(responseBody);
    print(data);
    //photo = data[''];
  } catch (e) {
    print('Excepcion \n $e');
  }
  return photo;
}

Future<String> getImageNetwork() async =>
    configure.checkInternet().then((bool conected) async {
      if (conected) {
        try {
          var res = await http.get(
            Uri.encodeFull(
                "https://pixabay.com/api/?key=14316831-b526440549b4ee06a100d780d&q=yellow+flowers&image_type=photo"),
          );
          print(res.statusCode);
          return compute(_parsePhotos, utf8.decode(res.bodyBytes));
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
    });
