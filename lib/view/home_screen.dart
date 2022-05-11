import 'package:dpma/controller/auth_store.dart';
import 'package:dpma/controller/home_store.dart';
import 'package:dpma/main.dart';
import 'package:dpma/model/doctor.dart';
import 'package:dpma/view/details_screen.dart';
import 'package:dpma/view/widgets/doctors_list.dart';
import 'package:dpma/view/widgets/doctors_tile.dart';
import 'package:dpma/view/widgets/fade_animation.dart';
import 'package:dpma/view/widgets/lottie/lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart' as _constants;
import '../injector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthStore _authStore = locator.get<AuthStore>();
  final HomeStore _homeStore = locator.get<HomeStore>();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isGrid = false;

  @override
  void initState() {
    super.initState();
    _homeStore.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        backgroundColor: _constants.primaryColorDark,
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 10.h,
                child: Center(
                    child: Image.asset(
                  'assets/bima-logo.png',
                  fit: BoxFit.fitHeight,
                )),
              ),
              const Divider(
                color: Colors.white,
              ),
              ListTile(
                tileColor: Colors.white,
                title: Text(
                  'Logout',
                  style: GoogleFonts.robotoCondensed(
                      textStyle: const TextStyle(
                          color: _constants.primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                onTap: () async {
                  await _authStore.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const Initialize(),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.view_headline,
              color: Color.fromRGBO(47, 87, 159, 1),
            )),
        title: Text(
          'BIMA DOCTOR',
          style: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(
                  color: Color.fromRGBO(47, 87, 159, 1),
                  fontWeight: FontWeight.bold)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon((isGrid) ? Icons.list : Icons.grid_view),
        onPressed: () {
          setState(() {
            isGrid = !isGrid;
          });
        },
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Center(
            child: Observer(
              builder: (BuildContext context) {
                switch (_homeStore.state) {
                  case HomeStoreState.loading:
                    return const LottieWidget(
                      lottieType: 'loading',
                    );
                  case HomeStoreState.loaded:
                    if (_homeStore.doctorsList.isEmpty) {
                      return const Text('No doctors available');
                    }
                    return (isGrid)
                        ? loadGrid(context, _homeStore.doctorsList)
                        : loadList(context, _homeStore.doctorsList);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  loadGrid(BuildContext context, List<Doctor> doctorsList) {
    return FadeAnimation(
      delay: 2000,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: doctorsList.length,
          itemBuilder: (BuildContext context, int index) {
            return DoctorsTile(
                doctor: doctorsList[index],
                onClick: (selectedDoctor) {
                  Navigator.of(context)
                      .push(MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              DetailsScreen(doctor: selectedDoctor)))
                      .then((value) => _homeStore.getDoctors());
                });
          }),
    );
  }

  loadList(BuildContext context, List<Doctor> doctorsList) {
    return FadeAnimation(
      delay: 1000,
      child: ListView.builder(
          itemCount: doctorsList.length,
          itemBuilder: (BuildContext context, int index) {
            return DoctorsList(
                doctor: doctorsList[index],
                onClick: (selectedDoctor) {
                  Navigator.of(context)
                      .push(MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              DetailsScreen(doctor: selectedDoctor)))
                      .then((value) => _homeStore.getDoctors());
                });
          }),
    );
  }
}
