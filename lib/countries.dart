import 'dart:convert';

import 'package:countries/countries_data.dart';
import 'package:countries/weather_model.dart';
import 'package:countries/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import './country_model.dart';
import './data_service.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

// void getallcountries()async{
//    var api = RestCountries.setup("YOUR_API_KEY");
//   List<Country> countries = await api.getCountries();
//   // see example for more details
// }
class _CountriesPageState extends State<CountriesPage> {
  final _weatherService = WeatherService();
  weatherResponse? _weatherresponse;
  String _countryselected = '';
  String? capital;
  String? currency;
  final _dataService = DataService();
  List<CountryResponse>? _response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Countries of the World'),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Autocomplete<Country>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return countryOptions
                    .where((Country county) => county.name
                        .toLowerCase()
                        .startsWith(textEditingValue.text.toLowerCase()))
                    .toList();
              },
              displayStringForOption: (Country option) => option.name,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  decoration: InputDecoration(
                      hintText: 'Search for a Country',
                      suffixIcon: Icon(Icons.search_sharp)),
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              },
              onSelected: (Country selection) {
                setState(() {
                  _countryselected = selection.toString();
                });
                _search(_countryselected);
                print('Selected: ${selection.name}');
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<Country> onSelected,
                  Iterable<Country> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: 300,
                      color: Colors.white,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Country option = options.elementAt(index);

                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option.name,
                                  style: const TextStyle(color: Colors.black)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          _response != null
              ? Container(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Country: $_countryselected'),
                          Text('Capital: $capital'),
                          Text('Currency: $currency'),
                        ],
                      ),
                    ),
                  ),
                )
              : Text('No Data Available'),
        ],
      ),
    );
  }

  void _search(String name) async {
    final response = await _dataService.getcountrydetails(name);
    setState(() {
      _response = response;
      capital = _response!.first.capital?.first.toString();
      currency = _response!.first.currencies?.aud?.name.toString();
      print(_response?.first.name?.common.toString());
      print(_response?.first.capital?.first.toString());
      print(_response?.first.currencies?.aud?.name.toString());
      getweatherdata(capital);
    });
  }

  //get weather data
  void getweatherdata(String? city) async {
    final response = await _weatherService.getWeather(city!);
    setState(() {
      _weatherresponse = response;
    });
    print('weather response:');
    print(_weatherresponse?.cityName.toString());
    print(_weatherresponse?.tempinfo.temperature);
  }
}
