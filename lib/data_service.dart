import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'country_model.dart';

class DataService {
  Future<List<CountryResponse>> getcountrydetails(String country) async {
    final uri = Uri.parse('https://restcountries.com/v3.1/name/${country}');
    Response response = await get(uri);
    // print(response.body);
    if (response.statusCode != 200) {}

    var data = (jsonDecode(response.body) as List)
        .map<CountryResponse>((e) => CountryResponse.fromJson(e))
        .toList();
    // var data = jsonDecode(response.body).cast<CountryResponse>();
    // print(json);
    print(data);

    return data;
    // return CountryResponse.fromJson(json);
  }

  //  Future<CountryResponse> getcountrylist(String country) async {
  //   final uri = Uri.parse('https://restcountries.com/v3.1/name/${country}');
  //   Response response = await get(uri);
  //   // print(response.body);
  //   final json = jsonDecode(response.body);
  //   print(json);
  //   return CountryResponse.fromJson(json);
  // }
}
