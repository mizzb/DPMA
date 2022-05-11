import 'package:dpma/controller/storage/storage_service.dart';
import 'package:dpma/model/doctor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/globals.dart';

class StorageServiceImpl extends StorageService {
  @override
  Future<List<Doctor>> getDoctors() async {
    final doctorsDB = await Hive.openBox('DoctorsDB');
    final resp = doctorsDB.get('doctors');
    List<Doctor> doctors = [];
    resp.forEach((elem) {
      doctors.add(elem);
    });
    doctors.sort((a,b) => a.rating!.compareTo(b.rating!)); /// Sorting based on rating  and saving to DB
    return doctors;
  }

  @override
  Future<bool> saveData(List<Doctor> doctors, bool overRide) async {
    try {
      final doctorsDB = await Hive.openBox('DoctorsDB');
      final resp = doctorsDB.get('doctors');
      if (!overRide && resp != null) {
        for (Doctor elem in resp) {
          if (elem.edit != null && elem.edit == true) {
            int index = doctors.indexWhere((element) => element.id == elem.id);
            doctors.removeAt(index);
            doctors.insert(index, elem);
          }
        }
      }
      doctorsDB.put('doctors', doctors);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<void> removeDb() async {
    await Hive.close();
    return await Hive.deleteFromDisk();
  }

  @override
  void stop() {
    Hive.close();
  }
}
