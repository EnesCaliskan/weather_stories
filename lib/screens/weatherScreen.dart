// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:weather_app/services/conditionService.dart';
import 'package:weather_app/widgets/weatherScreenWidgets.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, this.locationWeather, this.countryData}) : super(key: key);
  final dynamic locationWeather;
  final dynamic countryData;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ConditionModel conditionModel = ConditionModel();

  int temperature = 0;
  num windSpeed = 0.0;
  int humidity = 0;
  String country = '';
  String cityName = '';
  String backgroundImage = '';
  String description = '';
  String code = '';

  num feelsLike = 0;
  num tempMin = 0;
  num tempMax = 0;
  num windDeg = 0;
  String fullCountryName = '';

  void getFullCountryName(List<dynamic> countryData, String countryCode){
    setState(() {
        if(countryData == 'failed'){
            fullCountryName = '';
        } else {
        for(int  i=0; i<countryData.length; i++){
            if(countryData[i]['Code'] == countryCode){
               fullCountryName = countryData[i]['Name'];
          }
         }
       }
    });

  }


  void updateUI(dynamic weatherData){
      setState(() {
        if(weatherData == 'failed'){
          cityName = 'Could not find the city';
          backgroundImage = conditionModel.getWeatherImage(900);
        } else {
          num temp = weatherData['main']['temp'];
          temperature = temp.toInt();
          windSpeed = weatherData['wind']['speed'];
          humidity = weatherData['main']['humidity'];
          country = weatherData['sys']['country'];
          cityName = weatherData['name'];
          var condition = weatherData['weather'][0]['id'];
          backgroundImage = conditionModel.getWeatherImage(condition);
          description = weatherData['weather'][0]['main'];
          feelsLike = weatherData['main']['feels_like'];
          tempMin = weatherData['main']['temp_min'];
          tempMax = weatherData['main']['temp_max'];
          windDeg = weatherData['wind']['deg'];
        }
      });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    getFullCountryName(widget.countryData, country);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          ReturnBackgroundImage(imageUrl: backgroundImage),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReturnCitySearch(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReturnWeatherInfo(cityName: cityName, temperature: temperature),
                    ReturnWeatherDesc(description: description),
                  ],
                ),
              ),
              ReturnBottomInfoBar(humidity: humidity, windSpeed: windSpeed, country: country),
              Divider(color: Colors.black,
                thickness: 2.0,
                indent: MediaQuery.of(context).size.width / 3,
                endIndent: MediaQuery.of(context).size.width / 3,
                height: 30.0,
              ),
            ],
          ),
          ReturnSlidingUpPanel(country: fullCountryName, cityName: cityName,
              description: description, humidity: humidity,
              temperature: temperature, feelsLike: feelsLike,
              tempMin: tempMin, tempMax: tempMax, windSpeed: windSpeed, windDeg: windDeg),
        ],
      ),
    );
  }
}
