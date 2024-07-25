class UserModel {
String firstName;
String lastName;
String email;
String phoneNumber;
String password;
String role;
List<String> streets;
String? profilePicture;

UserModel({
required this.firstName,
required this.lastName,
required this.email,
required this.phoneNumber,
required this.password,
required this.role,
required this.streets,
this.profilePicture,
});

Map<String, dynamic> toJson() {
return {
'firstName': firstName,
'lastName': lastName,
'email': email,
'phoneNumber': phoneNumber,
'password': password,
'role': role,
'streets': streets,
'profilePicture': profilePicture,
};
}
}
