// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:mvvmclean/data/data_source/local_data_source.dart';
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
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

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

  @override
  Future<Either<Failure, ForgotPassword>> forgotPassword(
    ForgotPasswordRequest forgotPasswordRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(
          forgotPasswordRequest,
        );
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

  @override
  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
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

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHome();

          // // 🔍 طبع الـ response الخام قبل أي فحص
          // print('>>> [HOME RAW] status: ${response.status}');
          // print('>>> [HOME RAW] message: ${response.message}');
          // print('>>> [HOME RAW] data: ${response.data}');
          // print('>>> [HOME RAW] services: ${response.data?.services}');
          // print('>>> [HOME RAW] banners: ${response.data?.banners}');
          // print('>>> [HOME RAW] stores: ${response.data?.stores}');

          if (response.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveHomeData(response);
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
          // print('>>> [HOME ERROR] $error');
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, HomeDetailsObject>> getHomeDetails(int id) async {
    try {
      final response = await _localDataSource.getStoreDetails(id);
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHomeDetails(id);
          print('>>> [HOME DETAILS RAW] status: ${response.status}');
          print('>>> [HOME DETAILS RAW] message: ${response.message}');
          print('>>> [HOME DETAILS RAW] about: ${response.about}');
          print('>>> [HOME DETAILS RAW] services: ${response.services}');
          print('>>> [HOME DETAILS RAW] details: ${response.details}');
          print('>>> [HOME DETAILS RAW] image: ${response.image}');
          if (response.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveStoreDetails(response, id);
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
          print('>>> [HOME DETAILS ERROR] $error');
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
