import 'package:flutter/material.dart';
import 'package:weather_app/data/constants.dart' as constant;
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/ui/widgets/lottie_animation.dart';
import 'package:weather_app/utils/http_request.dart' as request;
import 'package:weather_app/utils/configure.dart'as configure;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: configure.convertColor("#0D0D0D"),
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: request.getImageNetwork(content: 'la paz'),
            builder: (context, content) {
              if (!content.hasData) {
                return SizedBox();
              } else {
                return Stack(children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(content.data, fit: BoxFit.cover)),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.85),
                  )
                ]);
              }
            },
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Body(),
            )
          ],
        ),
      ]),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  WeatherData _weatherData;

  @override
  void initState() {
    super.initState();
  }

  String _getDate() {
    DateTime _now = DateTime.now();
    String _day = constant.days[_now.weekday - 1].substring(0, 3);
    String _mounth = constant.mounths[_now.month - 1];
    return "$_day, $_mounth ${_now.day}";
  }

  Widget _header(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hello ${constant.exampleUser.name}',
                style: Theme.of(context).textTheme.title),
            Text(_getDate(), style: Theme.of(context).textTheme.subtitle),
          ],
        ),
        Expanded(
          child: LottieAnimation(
            animation: constant.lottieWeather['night'],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          32.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _header(context),
          Expanded(
            child: FutureBuilder(
              future: request.getWeatherCityInformation(
                  city: constant.exampleUser.city,
                  code: constant.exampleUser.codeCountry),
              builder: (context, content) {
                if (!content.hasData) {
                  return Center(
                      child: Wrap(
                    children: <Widget>[CircularProgressIndicator()],
                  ));
                }
                _weatherData = content.data;
                return MainData(weatherData: _weatherData);
              },
            ),
          )
        ],
      ),
    );
  }
}

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
