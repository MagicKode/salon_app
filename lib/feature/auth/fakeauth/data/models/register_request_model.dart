class RegisterRequestModel {
  final String phoneNumber;
  final String password;
  final String firstName;
  final String email;

  RegisterRequestModel({
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      'firstName': firstName,
      'email': email,
    };
  }
}
