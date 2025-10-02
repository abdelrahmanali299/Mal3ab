import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';

class MatchModel {
  List<UserModel>? players;
  DateTime? startDate, endDate;
  String? id;
  MatchModel({this.players, this.startDate, this.endDate, this.id});
  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    players: json['players'] != null
        ? List<UserModel>.from(
            json['players'].map((x) => UserModel.fromJson(x)),
          )
        : null,
    startDate: (json['startDate'] as Timestamp).toDate(),
    endDate: (json['endDate'] as Timestamp).toDate(),
    id: json['id'],
  );

  toJson() => {
    'players': players,
    'startDate': startDate,
    'endDate': endDate,
    'id': id,
  };
}
