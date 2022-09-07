//class CountryResponse {}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

//import 'package:meta/meta.dart';
//import 'dart:convert';

//List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

//String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryResponse {
  CountryResponse({
    required this.name,
    required this.capital,
    required this.currencies,
  });

  final Name? name;
  final Currencies? currencies;
  final List<String>? capital;

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      CountryResponse(
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        currencies: json["currencies"] == null
            ? null
            : Currencies.fromJson(json["currencies"]),
        capital: json["capital"] == null
            ? null
            : List<String>.from(json["capital"].map((x) => x)),
      );
}

class Name {
  Name({
    required this.common,
    required this.official,
  });

  final String? common;
  final String? official;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"] == null ? null : json["common"],
        official: json["official"] == null ? null : json["official"],
      );
}

class Currencies {
  Currencies({
    required this.aud,
  });

  final Aud? aud;

  factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
        aud: json["AUD"] == null ? null : Aud.fromJson(json["AUD"]),
      );
}

class Aud {
  Aud({
    required this.name,
    required this.symbol,
  });

  final String? name;
  final String? symbol;

  factory Aud.fromJson(Map<String, dynamic> json) => Aud(
        name: json["name"] == null ? null : json["name"],
        symbol: json["symbol"] == null ? null : json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "symbol": symbol == null ? null : symbol,
      };
}
