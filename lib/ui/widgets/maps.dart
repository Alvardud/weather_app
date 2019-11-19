import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class WeatherMap extends StatefulWidget {
  @override
  _WeatherMapState createState() => _WeatherMapState();
}

class _WeatherMapState extends State<WeatherMap> {
  MapController _controller;

  List<Marker> markers = [
    new Marker(
      width: 40.0,
      height: 40.0,
      point: new LatLng(51.5, -0.09),
      builder: (ctx) => new Container(
        child: new FlutterLogo(),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = MapController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: FlutterMap(
        mapController: _controller,
        options: MapOptions(
          maxZoom: 17.0,
          minZoom: 13.0,
          center: LatLng(51.5, -0.09),
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://tile.openweathermap.org/map/clouds/{z}/{x}/{y}.png?appid=75816b81c0e1be6fe46cdab220700cea"),
              
              //subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(markers: markers)
        ],
      ),
    );
  }
}
