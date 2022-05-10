import 'package:dpma/model/doctor.dart';

abstract class StorageService {
  Future<bool> saveData(List<Doctor> doctors, bool overRide);

  Future<List<Doctor>> getDoctors();

  void stop();
}
