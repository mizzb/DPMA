import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dpma/controller/repository/doctors_repo.dart';
import 'package:dpma/controller/storage/storage_service.dart';
import 'package:dpma/model/doctor.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../injector.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

enum HomeStoreState { loading, loaded }

abstract class HomeStoreBase with Store {
  HomeStoreBase();

  final DoctorsRepository _doctorsRepository = locator.get<DoctorsRepository>();
  final StorageService _storageService = locator.get<StorageService>();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  @observable
  List<Doctor> doctorsList = [];

  @observable
  ObservableFuture<List<Doctor>> _doctors =
      ObservableFuture(Future<List<Doctor>>(() => []));

  @observable
  ObservableFuture<bool> _dbFlag = ObservableFuture(Future<bool>(() => false));

  @computed
  HomeStoreState get state {
    if (_doctors.status == FutureStatus.pending ||
        _dbFlag.status == FutureStatus.pending) {
      return HomeStoreState.loading;
    } else {
      return HomeStoreState.loaded;
    }
  }

  @action
  Future<List<Doctor>?> getDoctors() async {
    _connectionStatus = await _connectivity.checkConnectivity();
    if (_connectionStatus == ConnectivityResult.none) {
      doctorsList = await getFromLocalStorage();
    } else {
      bool dbStatus = false;
      _doctors = ObservableFuture(Future<List<Doctor>>(
          () async => await _doctorsRepository.getDoctorsList()));
      doctorsList = await _doctors;
      if (doctorsList.isNotEmpty) {
        _dbFlag = ObservableFuture(Future<bool>(
            () async => await _storageService.saveData(doctorsList, false)));
        dbStatus = await _dbFlag;
        if (kDebugMode) {
          print('Write to db:' + dbStatus.toString());
        }
      }

      if (dbStatus) {
        doctorsList = await getFromLocalStorage();
      }
    }
    return doctorsList;
  }

  @action
  Future<bool> saveDoctor(Doctor doctor) async {
    _dbFlag = ObservableFuture(Future<bool>(
        () async => await _storageService.saveData(doctorsList, true)));
    bool resp = await _dbFlag;
    return resp;
  }

  getFromLocalStorage() async {
    _doctors = ObservableFuture(
        Future<List<Doctor>>(() async => await _storageService.getDoctors()));
    return _doctors;
  }
}
