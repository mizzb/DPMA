import 'package:dio/dio.dart';
import 'package:dpma/controller/auth_store.dart';
import 'package:dpma/controller/home_store.dart';
import 'package:dpma/controller/repository/doctors_repo.dart';
import 'package:dpma/controller/storage/storage_service.dart';
import 'package:dpma/controller/storage/storage_service_impl.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void initialize() {
  locator
      .registerLazySingleton<DoctorsRepository>(() => DoctorsRepository(Dio()));
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  locator.registerLazySingleton<AuthStore>(() => AuthStore());
  locator.registerLazySingleton<HomeStore>(() => HomeStore());
}
