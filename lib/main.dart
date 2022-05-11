import 'package:dpma/view/home_screen.dart';
import 'package:dpma/view/login_screen.dart';
import 'package:dpma/view/widgets/lottie/lottie_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart' as _constants;
import 'injector.dart';
import 'model/doctor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(DoctorAdapter());
  initialize();
  runApp(const DoctorsApp());
}

class DoctorsApp extends StatefulWidget {
  const DoctorsApp({Key? key}) : super(key: key);

  @override
  _DoctorsAppState createState() {
    return _DoctorsAppState();
  }
}

class _DoctorsAppState extends State<DoctorsApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: _constants.title,
          home: Initialize(),
        );
      },
    );
  }
}

class Initialize extends StatefulWidget {
  const Initialize({Key? key}) : super(key: key);

  @override
  _InitializeState createState() {
    return _InitializeState();
  }
}

class _InitializeState extends State<Initialize> {
  @override
  void initState() {
    super.initState();
    checkUserAuth(context);
  }

  checkUserAuth(context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>  const LoginScreen(),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const HomeScreen(),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LottieWidget(
          lottieType: 'loading',
        ),
      ),
    );
  }
}
