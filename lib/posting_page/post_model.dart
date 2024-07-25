class Location {
  double latitude;
  double longitude;

  Location({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PostModel {
  String name;
  String phoneNumber;
  String title;
  String description;
  String rentAmount;
  String rentPeriod;
  String district;
  Location location;
  List<String> amenities;
  List<String> images;

  PostModel({
    required this.name,
    required this.phoneNumber,
    required this.title,
    required this.description,
    required this.rentAmount,
    required this.rentPeriod,
    required this.district,
    required this.location,
    required this.amenities,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'title': title,
      'description': description,
      'rentAmount': rentAmount,
      'rentPeriod': rentPeriod,
      'district': district,
      'location': location.toJson(),
      'amenities': amenities,
      'images': images,
    };
  }
}
