// ignore_for_file: file_names
class ConditionModel {

  String getWeatherImage(int condition){
    if(condition < 300){
        return 'assets/images/storm.jpg';
    } else if(condition < 400){
      return 'assets/images/drizzle.jpg';
    } else if(condition < 600){
      return 'assets/images/rain.jpg';
    } else if(condition < 700){
      return 'assets/images/snow.jpg';
    } else if(condition < 800){
      return 'assets/images/fog.jpg';
    } else if(condition == 800){
      return 'assets/images/clear.jpg';
    } else if(condition <= 804){
      return 'assets/images/cloudy.jpg';
    } else{
      return 'assets/images/else.jpg';
    }
  }



}