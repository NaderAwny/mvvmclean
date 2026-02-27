import 'package:mvvmclean/data/network/app_api.dart';
import 'package:mvvmclean/data/network/requests.dart';
import 'package:mvvmclean/data/responses/responses.dart';

//Single Responsibility Principle
abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }
}


