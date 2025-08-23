class UserModel {
  final String image;
  final String name;
  final bool isLooged;
  final String email;
  final String password;

  UserModel({
    required this.image,
    required this.name,
    required this.isLooged,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      image: jsonData['image'],
      name: jsonData['name'],
      isLooged: jsonData['isLooged'],
      email: jsonData['email'],
      password: jsonData['password'],
    );
  }
}
