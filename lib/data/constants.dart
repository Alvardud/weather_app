import 'package:weather_app/models/configure_user.dart';

const List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const List<String> mounths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

const Map<String, String> lottieWeather = {
  'sunny': "assets/animations/weather-sunny.json",
  'night': "assets/animations/weather-night.json",
};

const Map<String, String> lottieResources = {
  'loading': "assets/animations/loading.json",
};

ConfigureUser exampleUser =
    ConfigureUser(city: 'Roma', codeCountry: 'it', name: 'Alvaro');

String mapCloudy =
    "https://tile.openweathermap.org/map/clouds/{z}/{x}/{y}.png?appid=75816b81c0e1be6fe46cdab220700cea";
  