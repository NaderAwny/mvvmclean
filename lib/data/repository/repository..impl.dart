import 'package:dartz/dartz.dart';
import 'package:mvvmclean/data/data_source/remote_data_source.dart';
import 'package:mvvmclean/data/mappers/mapper.dart';
import 'package:mvvmclean/data/network/error_handler.dart';
import 'package:mvvmclean/data/network/failure.dart';
import 'package:mvvmclean/data/network/network_info.dart';
import 'package:mvvmclean/data/network/requests.dart';
import 'package:mvvmclean/domain/model/models.dart';
import 'package:mvvmclean/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEAFULT,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
