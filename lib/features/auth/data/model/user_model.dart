class UserModel {
  String? id;
  String image;
  final String name;
  bool isLooged;
  final String email;
  final String? password;

  UserModel({
    this.id,
    required this.image,
    required this.name,
    this.isLooged = false,
    required this.email,
    this.password,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
      isLooged: jsonData['isLooged'],
      email: jsonData['email'],
    );
  }
  toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'isLooged': isLooged,
      'email': email,
    };
  }
}
