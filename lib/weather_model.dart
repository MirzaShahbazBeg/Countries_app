/*
{
  
  "weather": [
    {
     
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  
  "main": {
    "temp": 282.55,
   
  },

  "name": "Mountain View",
  
  }                         

*/

// to parse the json ,create a class for every json object.

class WeatherInfo {
  final String desc;
  final String icon;
  WeatherInfo({required this.desc, required this.icon});
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final desc = json['description'];
    final icon = json['icon'];
    return WeatherInfo(desc: desc, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;
  TemperatureInfo({required this.temperature});
  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp']; //key inside json
    return TemperatureInfo(temperature: temperature);
  }
}

class weatherResponse {
  final String cityName;
  final TemperatureInfo tempinfo;
  final WeatherInfo weatherinfo; //another class
  weatherResponse(
      {required this.cityName,
      required this.tempinfo,
      required this.weatherinfo});
  factory weatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name']; //key inside json
    final tempInfojson = json['main']; //key inside json from another class
    final tempinfo = TemperatureInfo.fromJson(tempInfojson);
    final weatherinfojson = json['weather'][0];
    final weatherinfo = WeatherInfo.fromJson(weatherinfojson);
    return weatherResponse(
        cityName: cityName, tempinfo: tempinfo, weatherinfo: weatherinfo);
  }
}
