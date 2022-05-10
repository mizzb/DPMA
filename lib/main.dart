import 'package:dpma/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'injector.dart';
import 'model/doctor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(DoctorAdapter());
  initialize();
  runApp(const DoctorsApp());
}

class DoctorsApp extends StatelessWidget {
  const DoctorsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return const MaterialApp(
          title: 'DPMA',
          home: HomeScreen(),
        );
      },
    );
  }
}
