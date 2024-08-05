class User_Agent {
  final String firstName;
  final String lastName;
  final String profilePicture;
  final String phoneNumber;
  final String street;

  User_Agent({
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.phoneNumber,
    required this.street,
  });

  factory User_Agent.fromJson(Map<dynamic, dynamic> json) {
    return User_Agent(
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
      phoneNumber: json['phoneNumber'],
      street: json['streets'][0], // assuming streets is a list and taking the first one
    );
  }
}
