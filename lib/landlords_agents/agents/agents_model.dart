class User_Agent {
  final String name;
  final String assetImagePath;
  final String locationName;

  User_Agent({
    required this.name,
    required this.assetImagePath,
    required this.locationName,
  });
}

final List<User_Agent> users = [
  User_Agent(name: 'Nashon Israel', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Magomeni'),
  User_Agent(name: 'Nestory Silyvester', assetImagePath: 'assets/img/agent.jpg', locationName: 'Kinondini Mwanamboka'),
  User_Agent(name: 'Juma Khasim', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Upagnga'),
  User_Agent(name: 'Maryam Masoud', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Mwananyamara '),
  User_Agent(name: 'Peter Mapolu', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Makumbusho'),
  User_Agent(name: 'Daniel Future', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Makumbusho juu'),
  User_Agent(name: 'BUbex Bakari', assetImagePath: 'assets/img/landlord.jpg', locationName: 'Location 7'),
  User_Agent(name: 'Bakari Sonde', assetImagePath: 'assets/img/agent.jpg', locationName: 'Location 8'),
  User_Agent(name: 'Joseph Lusendekwa', assetImagePath: 'assets/img/agent.jpg', locationName: 'Location 9'),
  User_Agent(name: 'Naomy Moyo', assetImagePath: 'assets/img/agent.jpg', locationName: 'Location 10'),
];
