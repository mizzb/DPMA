// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<HomeStoreState>? _$stateComputed;

  @override
  HomeStoreState get state =>
      (_$stateComputed ??= Computed<HomeStoreState>(() => super.state,
              name: 'HomeStoreBase.state'))
          .value;

  late final _$doctorsListAtom =
      Atom(name: 'HomeStoreBase.doctorsList', context: context);

  @override
  List<Doctor> get doctorsList {
    _$doctorsListAtom.reportRead();
    return super.doctorsList;
  }

  @override
  set doctorsList(List<Doctor> value) {
    _$doctorsListAtom.reportWrite(value, super.doctorsList, () {
      super.doctorsList = value;
    });
  }

  late final _$_doctorsAtom =
      Atom(name: 'HomeStoreBase._doctors', context: context);

  @override
  ObservableFuture<List<Doctor>> get _doctors {
    _$_doctorsAtom.reportRead();
    return super._doctors;
  }

  @override
  set _doctors(ObservableFuture<List<Doctor>> value) {
    _$_doctorsAtom.reportWrite(value, super._doctors, () {
      super._doctors = value;
    });
  }

  late final _$_dbFlagAtom =
      Atom(name: 'HomeStoreBase._dbFlag', context: context);

  @override
  ObservableFuture<bool> get _dbFlag {
    _$_dbFlagAtom.reportRead();
    return super._dbFlag;
  }

  @override
  set _dbFlag(ObservableFuture<bool> value) {
    _$_dbFlagAtom.reportWrite(value, super._dbFlag, () {
      super._dbFlag = value;
    });
  }

  late final _$getDoctorsAsyncAction =
      AsyncAction('HomeStoreBase.getDoctors', context: context);

  @override
  Future<List<Doctor>?> getDoctors() {
    return _$getDoctorsAsyncAction.run(() => super.getDoctors());
  }

  late final _$saveDoctorAsyncAction =
      AsyncAction('HomeStoreBase.saveDoctor', context: context);

  @override
  Future<bool> saveDoctor(Doctor doctor) {
    return _$saveDoctorAsyncAction.run(() => super.saveDoctor(doctor));
  }

  @override
  String toString() {
    return '''
doctorsList: ${doctorsList},
state: ${state}
    ''';
  }
}
