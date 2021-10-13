// ignore_for_file: file_names
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'locationService.dart';

class WeatherService{

  NetworkHelper networkHelper = NetworkHelper();
  String apiKey = 'e5210f93cff5297ecea98cb0486a1d26';


  Future<dynamic> getCurrentLocationData() async {

    Position currentPosition = await networkHelper.getPosition();
    double latitude = currentPosition.latitude;
    double longitude = currentPosition.longitude;

    String url = 'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      String data = response.body;
      var decodedData =  jsonDecode(data);
      return decodedData;
    }
    else{
      return('Application failed with ${response.statusCode}');
    }
  }

  Future<dynamic> getCityWeatherData(String cityName) async{

    String url = 'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return ('failed');
    }

  }




}