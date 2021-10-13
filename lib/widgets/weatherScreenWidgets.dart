// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:weather_app/screens/weatherScreen.dart';
import 'package:weather_app/services/weatherService.dart';
Color kPetrol = const Color(0xFF18515E);

class ReturnCitySearch extends StatefulWidget {
  const ReturnCitySearch({Key? key, isCitySearched}) : super(key: key);

  @override
  _ReturnCitySearchState createState() => _ReturnCitySearchState();
}

class _ReturnCitySearchState extends State<ReturnCitySearch> {

  final citySearchController = TextEditingController();
  WeatherService weatherService = WeatherService();
  bool isTyping = false;

  void getSearchedCityWeather(String cityName) async{
    var weatherData = await weatherService.getCityWeatherData(cityName);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(locationWeather: weatherData);
    }));
  }

  void getCurrentCityWeather() async{
    var weatherData = await weatherService.getCurrentLocationData();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(locationWeather: weatherData);
    }));
  }

  IconButton returnHomeButton(){
    return IconButton(
      icon: Icon(Icons.home, color: kPetrol,),
      onPressed: (){
        setState(() {
          getCurrentCityWeather();
        });
      },
    );
  }

  IconButton returnDeleteButton(){
    return IconButton(
      icon: Icon(Icons.clear, color: kPetrol,),
      onPressed: (){
        setState(() {
          citySearchController.clear();
          isTyping = false;
        });
      },
    );
  }

  @override
  void dispose() {
    citySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
      child: TextField(
        controller: citySearchController,
        onChanged: (text){
            setState(() {
              isTyping = true;
            });
        },
        decoration: InputDecoration(
            prefixIcon: isTyping ? returnDeleteButton() : returnHomeButton(),
            suffixIcon: IconButton(
              icon: Icon(Icons.location_city, color: kPetrol,),
              onPressed: (){
                setState(() {
                  getSearchedCityWeather(citySearchController.text);
                });
              },
            ),
            filled: true,
            fillColor: Colors.blue.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
        ),
      ),
    );
  }
}

class ReturnWeatherInfo extends StatefulWidget {
  const ReturnWeatherInfo({Key? key, required this.temperature, required this.cityName,}) : super(key: key);

  final int temperature;
  final String cityName;

  @override
  _ReturnWeatherInfoState createState() => _ReturnWeatherInfoState();
}
class _ReturnWeatherInfoState extends State<ReturnWeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 30.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.cityName, style: TextStyle(
              fontSize: 26.0,
              color: kPetrol,
            ),
            ),
            Text('${widget.temperature}°', style: TextStyle(
              fontSize: 98.0,
              color: kPetrol,
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnWeatherDesc extends StatefulWidget {
  const ReturnWeatherDesc({Key? key, required this.description}) : super(key: key);
  final String description;

  @override
  _ReturnWeatherDescState createState() => _ReturnWeatherDescState();
}
class _ReturnWeatherDescState extends State<ReturnWeatherDesc> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 50.0),
      child: RotatedBox(
          quarterTurns: 3,
          child: Text(widget.description,
            style: TextStyle(
                fontSize: 22.0,
                color: kPetrol,
            ),
          )
      ),
    );
  }
}


class ReturnBottomInfoBar extends StatefulWidget {
  const ReturnBottomInfoBar({Key? key, required this.humidity, required this.windSpeed, required this.country}) : super(key: key);
  final int humidity;
  final num windSpeed;
  final String country;

  @override
  _ReturnBottomInfoBarState createState() => _ReturnBottomInfoBarState();
}
class _ReturnBottomInfoBarState extends State<ReturnBottomInfoBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('${widget.humidity}%', style: TextStyle(fontSize: 16.0),),
                  Text('Humidity'),
                ],
              ),
              VerticalDivider(color: Colors.black, thickness: 1.0,),
              Column(
                children: [
                  Text('${widget.windSpeed}km/h', style: TextStyle(fontSize: 16.0),),
                  Text('Wind'),
                ],
              ),
              VerticalDivider(color: Colors.black, thickness: 1.0,),
              Column(
                children: [
                  Text(widget.country, style: TextStyle(fontSize: 16.0),),
                  Text('Country'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ReturnBackgroundImage extends StatefulWidget {
  const ReturnBackgroundImage({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  _ReturnBackgroundImageState createState() => _ReturnBackgroundImageState();
}

class _ReturnBackgroundImageState extends State<ReturnBackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(widget.imageUrl), fit: BoxFit.cover),
      ),
    );
  }
}

