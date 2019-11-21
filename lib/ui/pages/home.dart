import 'package:flutter/material.dart';
import 'package:weather_app/controllers/drawer_controller.dart';
import 'package:weather_app/data/constants.dart' as constant;
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/ui/widgets/lottie_animation.dart';
import 'package:weather_app/ui/widgets/search.dart';
import 'package:weather_app/utils/http_request.dart' as request;
import 'package:weather_app/utils/configure.dart' as configure;
import 'package:weather_app/ui/widgets/main_data_home.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: configure.convertColor("#0D0D0D"),
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            //future: request.getImageNetwork(content: constant.exampleUser.city),
            future: request.getImageNetwork(content: "scattered clouds"),
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
                    color: Colors.black.withOpacity(0.4),
                  )
                ]);
              }
            },
          ),
        ),
        Content()
      ]),
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  double scrollPercent = 0.0;

  String _getDate() {
    DateTime _now = DateTime.now();
    String _day = constant.days[_now.weekday - 1].substring(0, 3);
    String _mounth = constant.mounths[_now.month - 1];
    return "$_day, $_mounth ${_now.day}";
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top),
            SizedBox(height: 150.0, child: _header(context)),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Body(
                scrollPercent: scrollPercent,
              ),
            )
          ],
        ),
        Search(
          onScroll: (double scrollPercent) {
            setState(() {
              this.scrollPercent = scrollPercent;
            });
          },
        )
      ],
    );
  }
}

class Body extends StatelessWidget {
  final double scrollPercent;
  WeatherData _weatherData;

  Body({this.scrollPercent});

  Widget _noData(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          182.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LottieAnimation(
            animation: constant.lottieResources['loading'],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text('Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset(scrollPercent*2.3, 0.0),
          child: SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            182.0,
        child: FutureBuilder(
          future: request.getWeatherCityInformation(
              city: constant.exampleUser.city,
              code: constant.exampleUser.codeCountry),
          builder: (context, content) {
            if (!content.hasData) {
              return _noData(context);
            }
            _weatherData = content.data;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MainData(weatherData: _weatherData),
                  SizedBox(
                    height: 16.0,
                  ),
                  Divider(
                    color: Colors.white,
                    height: 16.0,
                    indent: 32.0,
                    endIndent: 32.0,
                    thickness: 2.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
