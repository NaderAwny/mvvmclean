import 'package:dartz/dartz.dart';
import 'package:mvvmclean/data/network/failure.dart';
import 'package:mvvmclean/data/network/requests.dart';
import 'package:mvvmclean/domain/model/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
