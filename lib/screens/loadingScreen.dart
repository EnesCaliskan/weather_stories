// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:weather_app/screens/weatherScreen.dart';
import 'package:weather_app/services/weatherService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Color kPetrol = const Color(0xFF18515E);
  WeatherService weatherService = WeatherService();

  void getWeather() async{
    var weatherData = await weatherService.getCurrentLocationData();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(locationWeather: weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCube(
            color: kPetrol,
            size: 100.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Loading Weather Data...',
              style: TextStyle(fontSize: 24.0, color: kPetrol),
            ),
          ),
        ],
      ),
    );
  }
}
