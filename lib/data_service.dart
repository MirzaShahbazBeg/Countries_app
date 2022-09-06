import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'country_model.dart';

class DataService {
  Future<CountryResponse> getcountrydetails(String country) async {
    final uri = Uri.parse('https://restcountries.com/v3.1/name/${country}');
    Response response = await get(uri);
    // print(response.body);
    final json = jsonDecode(response.body);
    // print(json);
    return CountryResponse.fromJson(json);
  }
}
