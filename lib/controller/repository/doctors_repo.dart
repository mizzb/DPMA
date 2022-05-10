import 'package:dio/dio.dart';
import 'package:dpma/model/doctor.dart';
import 'package:dpma/model/globals.dart';
import 'package:flutter/material.dart';

class DoctorsRepository {
  final Dio _dio;

  DoctorsRepository(this._dio);

  Future<List<Doctor>> getDoctorsList() async {
    var resp =
        await _dio.get('https://5efdb0b9dd373900160b35e2.mockapi.io/contacts');
    List<Doctor> doctors = [];
    if (resp.statusCode == 200) {
      resp.data.forEach((elem) {
        doctors.add(Doctor.fromJson(elem));
      });
      return doctors;
    } else {
      snackbarKey.currentState?.showSnackBar(
          const SnackBar(content: Text('Fetching doctors failed')));
      return doctors;
    }
  }
}
