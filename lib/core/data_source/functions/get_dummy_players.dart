import 'package:mal3ab/features/auth/data/model/user_model.dart';

List<UserModel> getDummyPlayers() {
  return List.generate(
    5,
    (i) => UserModel(
      id: i.toString(),
      name: 'Player $i',
      email: 'player${i + 1}@gmail.com',
      image: 'assets/images/3551911.jpg',
    ),
  );
}
