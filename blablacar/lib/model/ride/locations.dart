///
/// Enumation of available BlaBlaCar countries
///
enum Country {
  france('France'),
  uk('United Kingdom'),
  spain('Spain');

  final String name;

  const Country(this.name);
}

///
/// This model describes a location (city, street).
///
class Location {
  final String name;
  final Country country;

  const Location({required this.name, required this.country});

//this operator is to tell Dart: 
//"Two Location objects should be considered 'the same' if their data matches, even if they aren't the exact same instance."
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location && other.name == name && other.country == country;
  }
//The hashCode is an integer representation of the object used by Hash-based collections (like Set or the keys in a Map).
//The goal is to ensure that if $a == b$, then $a.hashCode == b.hashCode. it to use hash code later in the set
//Whenever someone asks for the hashCode of this Location, quickly take the unique ID of the name, take the unique ID of the country, 
//perform that bitwise 'mixing' (XOR) on them, and give me back the result as a single integer.

  @override
  int get hashCode => name.hashCode ^ country.hashCode;

  @override
  String toString() {
    return name;
  }
}

///
/// This model describes a street.
///
class Street {
  final String name;
  final Location city;

  const Street({required this.name, required this.city});
}
