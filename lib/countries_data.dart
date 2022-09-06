class Country {
  const Country({
    required this.name,
  });

  final String name;

  @override
  String toString() {
    return '$name';
  }
}

const List<Country> countryOptions = <Country>[
  Country(name: 'Africa'),
  Country(name: 'Austria'),
  Country(name: 'Australia'),
  Country(name: 'Bulgaria'),
  Country(name: 'Canada'),
  Country(name: 'Denmark'),
  Country(name: 'Paris'),
  Country(name: 'India'),
  Country(name: 'North America'),
  Country(name: 'South America'),
  Country(name: 'Afghanistan'),
  Country(name: 'Bangladesh'),
];
