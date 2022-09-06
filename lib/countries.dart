import 'dart:convert';

import 'package:countries/countries_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import './country_model.dart';
import './data_service.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  String _countryselected = '';
  final _dataService = DataService();
  CountryResponse? _response;
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
          Container(
            height: 200,
            width: double.infinity,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Country: $_countryselected'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _search(String name) async {
    final response = await _dataService.getcountrydetails(name);
    setState(() {
      _response = response;
      print(_response?.name?.common.toString());
    });
  }
}
