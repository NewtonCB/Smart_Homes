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
  String timestamp;

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
    required this.timestamp,
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
      'timestamp': timestamp,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      title: json['title'],
      description: json['description'],
      rentAmount: json['rentAmount'],
      rentPeriod: json['rentPeriod'],
      district: json['district'],
      location: Location.fromJson(json['location']),
      amenities: List<String>.from(json['amenities']),
      images: List<String>.from(json['images']),
      timestamp: json['timestamp'],
    );
  }
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
