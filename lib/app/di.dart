import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvmclean/app/app_prefs.dart';
import 'package:mvvmclean/data/data_source/remote_data_source.dart';
import 'package:mvvmclean/data/network/app_api.dart';
import 'package:mvvmclean/data/network/dio_factory.dart';
import 'package:mvvmclean/data/network/network_info.dart';
import 'package:mvvmclean/data/repository/repository..impl.dart';
import 'package:mvvmclean/domain/repository/repository.dart';
import 'package:mvvmclean/domain/usecase/login_usecase.dart';
import 'package:mvvmclean/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies
  //shared preferences instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  // internet connection checker with custom addresses
  instance.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(
      addresses: [
        AddressCheckOption(
          uri: Uri.parse('https://google.com'),
          timeout: const Duration(seconds: 5),
        ),
        AddressCheckOption(
          uri: Uri.parse('https://cloudflare.com'),
          timeout: const Duration(seconds: 5),
        ),
        AddressCheckOption(
          uri: Uri.parse('https://example.com'),
          timeout: const Duration(seconds: 5),
        ),
      ],
    ),
  );

  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(instance<InternetConnectionChecker>()),
  );

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  //dio
  final dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<AppServiceClient>()),
  );
  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()),
  );
}

// ignore: strict_top_level_inference
initLoginModule() {
  if (!instance.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
