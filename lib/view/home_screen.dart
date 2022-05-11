import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dpma/controller/auth_store.dart';
import 'package:dpma/controller/home_store.dart';
import 'package:dpma/main.dart';
import 'package:dpma/model/doctor.dart';
import 'package:dpma/view/details_screen.dart';
import 'package:dpma/view/widgets/doctors_list.dart';
import 'package:dpma/view/widgets/doctors_tile.dart';
import 'package:dpma/view/widgets/error_image.dart';
import 'package:dpma/view/widgets/fade_animation.dart';
import 'package:dpma/view/widgets/lottie/lottie_widget.dart';
import 'package:dpma/view/widgets/placeholder_image.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final AuthStore _authStore = locator.get<AuthStore>();
  final HomeStore _homeStore = locator.get<HomeStore>();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late AnimationController _animationController;
  bool isPlaying = false;
  bool isGrid = false;

  @override
  void initState() {
    super.initState();
    _homeStore.getDoctors();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: appDrawer(context),
      appBar: appBar(),
      floatingActionButton: FloatingActionButton(
        child: AnimatedIcon(
          icon: AnimatedIcons.view_list,
          progress: _animationController,
        ),
        // child: AnimatedIcon((isGrid) ? Icons.list : Icons.grid_view),
        onPressed: () {
          isPlaying = !isPlaying;
          isPlaying
              ? _animationController.forward()
              : _animationController.reverse();
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
                      lottieType: _constants.lottieLoad,
                    );
                  case HomeStoreState.loaded:
                    if (_homeStore.doctorsList.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          LottieWidget(
                            lottieType: _constants.lottieEmpty,
                          ),
                          Text(_constants.noDoctorsText),
                        ],
                      );
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

  AppBar appBar() {
    return AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.view_headline,
              color: _constants.primaryColorDark,
            )),
        title: Text(
          _constants.titleText,
          style: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(
                  color: _constants.primaryColorDark,
                  fontWeight: FontWeight.bold)),
        ),
        actions: [
          Image.asset(
            _constants.bimaLogoWhite,
            height: AppBar().preferredSize.height,
          ),
        ]);
  }

  Drawer appDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: _constants.primaryColorDark,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 10.h,
              child: Center(
                  child: Image.asset(
                _constants.bimaLogo,
                height: AppBar().preferredSize.height,
              )),
            ),
            const Divider(
              color: Colors.white,
            ),
            ListTile(
              tileColor: Colors.white,
              leading: const Icon(
                Icons.logout,
                color: _constants.primaryColorDark,
              ),
              title: Text(
                _constants.logoutText,
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
    );
  }

  loadGrid(BuildContext context, List<Doctor> doctorsList) {
    return FadeAnimation(
      delay: 2000,
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: getCarousel(doctorsList)),
          const Divider(color: _constants.colorAccent,),
          Expanded(
            flex: 8,
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
          ),
        ],
      ),
    );
  }

  CarouselSlider getCarousel(List<Doctor> doctorsList) {
    return CarouselSlider(
              options: CarouselOptions(autoPlay: true, aspectRatio: 3 / 1, enlargeCenterPage: true),
              items: [0, 1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: 90.w,
                      child: Card(
                          child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CachedNetworkImage(
                              imageUrl: doctorsList[i].profilePic!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 25.w,
                                height: 15.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: _constants.colorAccent),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const PlaceHolderImage(),
                              errorWidget: (context, url, error) =>
                                  const ErrorImage(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    doctorsList[i].firstName! +
                                        ' ' +
                                        doctorsList[i].lastName!,
                                    maxLines: 1,
                                    style: GoogleFonts.robotoCondensed(
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: _constants
                                                .primaryColorDark))),

                                Text(
                                        doctorsList[i].specialization!,
                                    maxLines: 1,
                                    style: GoogleFonts.robotoCondensed(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: _constants
                                                .primaryColorDark))),
                                Divider(),
                                Text(
                                    doctorsList[i].primaryContactNo!,
                                    style: GoogleFonts.robotoCondensed(
                                        textStyle: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _constants
                                                .colorAccent))),
                                Text(
                                    doctorsList[i].emailAddress!,
                                    style: GoogleFonts.robotoCondensed(
                                        textStyle: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _constants
                                                .colorAccent))),

                              ],
                            )
                          ],
                        ),
                      )),
                    );
                  },
                );
              }).toList(),
            );
  }

  loadList(BuildContext context, List<Doctor> doctorsList) {
    return FadeAnimation(
      delay: 1000,
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: getCarousel(doctorsList)),
          const Divider(color: _constants.colorAccent,),
          Expanded(
            flex: 8,
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
          ),
        ],
      ),
    );
  }
}
