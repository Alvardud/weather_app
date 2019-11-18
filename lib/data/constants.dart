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
  'sunny' : "assets/animations/weather-sunny.json",
  'night' : "assets/animations/weather-night.json"
};


ConfigureUser exampleUser = ConfigureUser(
  city: 'La Paz',
  codeCountry: 'Bo',
  name: 'Alvaro'
);