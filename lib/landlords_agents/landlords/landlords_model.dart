class User {
  final String name;
  final String assetImagePath;
  final String locationName;
  final String phoneNumber;
  final double rating;

  User({
    required this.name,
    required this.assetImagePath,
    required this.locationName,
    required this.phoneNumber,
    this.rating = 0.0, // Default rating value
  });
}

final List<User> users = [
  User(name: 'Nashon Israel', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Magomeni', phoneNumber: '1234567890', rating: 4.5),
  User(name: 'Nestory Silyvester', assetImagePath: 'assets/img/agent.jpg', locationName: 'Kinondini Mwanamboka', phoneNumber: '0987654321', rating: 4.0),
  User(name: 'Juma Khasim', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Upagnga', phoneNumber: '1234567890', rating: 4.0),
  User(name: 'Maryam Masoud', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Mwananyamara', phoneNumber: '1234567890', rating: 3.5),
  User(name: 'Peter Mapolu', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Makumbusho', phoneNumber: '1234567890', rating: 3.0),
  User(name: 'Daniel Future', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Makumbusho juu', phoneNumber: '1234567890', rating: 5.0),
  User(name: 'BUbex Bakari', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Location 7', phoneNumber: '1234567890', rating: 2.5),
  User(name: 'Bakari Sonde', assetImagePath: 'assets/img/agent.jpg', locationName: 'Location 8', phoneNumber: '1234567890', rating: 4.2),
  User(name: 'Joseph Lusendekwa', assetImagePath: 'assets/img/agent.jpg', locationName: 'Location 9', phoneNumber: '1234567890', rating: 3.8),
  User(name: 'Naomy Moyo', assetImagePath: 'assets/img/agent.jpg', locationName: 'Location 10', phoneNumber: '1234567890', rating: 3.9),
];
