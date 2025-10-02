import 'package:dartz/dartz.dart';
import 'package:mal3ab/core/services/failure.dart';
import 'package:mal3ab/features/admin/data/models/match_model.dart';

abstract class AdminRepo {
  Future<Either<Failure, void>> addMatch({
    required MatchModel matchModel,
    required String mainId,
    required String mainPath,
  });

  Future<Either<Failure, MatchModel?>> getNewestMatch(String mainPath);
}
