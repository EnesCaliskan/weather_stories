// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier{
  late double _latitude;
  late double _longitude;

  WeatherProvider(){
    _latitude = 0.0;
    _longitude = 0.0;
  }

  //getters
  double get latitude => _latitude;
  double get longitude => _longitude;

  //setters
  void setLatitude(double latitude){
    _latitude = latitude;
    notifyListeners();
  }

  void setLongitude(double longitude){
    _longitude = longitude;
    notifyListeners();
  }




}