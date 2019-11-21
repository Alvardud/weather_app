import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data.dart';

class MainData extends StatelessWidget {
  final WeatherData weatherData;
  MainData({this.weatherData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${weatherData.main.temp.round()}°" ?? "null",
            style: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.w300,
                color: Colors.white),
          ),
          Text(
            "${weatherData.weather[0].description[0].toUpperCase()}${weatherData.weather[0].description.substring(1)}",
            style: TextStyle(fontSize: 28.0, color: Colors.white),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  weatherData.main.temp > weatherData.main.tempMin
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: Colors.white),
              Text(
                "${weatherData.main.tempMin.round()}°",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
              SizedBox(
                width: 8.0,
              ),
              Icon(
                  weatherData.main.temp > weatherData.main.tempMax
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: Colors.white),
              Text(
                "${weatherData.main.tempMax.round()}°",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
