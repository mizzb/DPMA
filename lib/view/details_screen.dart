import 'dart:io';

import 'package:dpma/controller/home_store.dart';
import 'package:dpma/model/doctor.dart';
import 'package:dpma/view/widgets/auth_button.dart';
import 'package:dpma/view/widgets/doctors_details_bg.dart';
import 'package:dpma/view/widgets/lottie/lottie_widget.dart';
import 'package:dpma/view/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart' as _constants;
import '../injector.dart';

class DetailsScreen extends StatefulWidget {
  final Doctor doctor;

  const DetailsScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  _DetailsScreenState createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _isEdit = false;
  final HomeStore _homeStore = locator.get<HomeStore>();
  late File _pickedImage;
  late dynamic _profilePic;

  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _contactCtrl = TextEditingController();

  final TextEditingController _dayCtrl = TextEditingController();
  final TextEditingController _monthCtrl = TextEditingController();
  final TextEditingController _yearCtrl = TextEditingController();

  final TextEditingController _bloodCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();
  final TextEditingController _weightCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameCtrl.text = widget.doctor.firstName!;
    _lastNameCtrl.text = widget.doctor.lastName!;
    _contactCtrl.text = widget.doctor.primaryContactNo!;
    _profilePic = widget.doctor.profilePic!;
    _dayCtrl.text = (widget.doctor.day != null) ? widget.doctor.day! : '';
    _monthCtrl.text = (widget.doctor.month != null) ? widget.doctor.month! : '';
    _yearCtrl.text = (widget.doctor.year != null) ? widget.doctor.year! : '';

    _bloodCtrl.text =
        (widget.doctor.bloodGroup != null) ? widget.doctor.bloodGroup! : '';
    _heightCtrl.text =
        (widget.doctor.height != null) ? widget.doctor.height! : '';
    _weightCtrl.text =
        (widget.doctor.weight != null) ? widget.doctor.weight! : '';
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _contactCtrl.dispose();
    _dayCtrl.dispose();
    _monthCtrl.dispose();
    _yearCtrl.dispose();
    _bloodCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: _constants.primaryColorDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              DoctorDetailsBG(
                imageLink: _profilePic,
                ctxt: context,
              ),
              buildDetails()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetails() {
    return Container(
      padding: EdgeInsets.all(2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10.h + 20.w,
          ),
          if (_isEdit)
            GestureDetector(
              onTap: () async {
                var res =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (res != null) {
                  _pickedImage = File(res.path);
                  setState(() {
                    _profilePic = _pickedImage;
                  });
                }
              },
              child: Text(
                _constants.updateImgText,
                style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(color: _constants.colorAccent)),
              ),
            ),
          SizedBox(height: 2.h),
          Text(
            widget.doctor.firstName! + ' ' + widget.doctor.lastName!,
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoCondensed(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          AuthButton(
              callBack: () async {
                if (!_isEdit) {
                  setState(() {
                    _isEdit = true;
                  });
                } else {
                  bool resp = await saveChanges();
                  if (resp) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Changes Saved')));
                    setState(() {
                      _isEdit = false;
                    });
                  }
                }
              },
              buttonText:
                  (_isEdit) ? _constants.saveText : _constants.editText),
          SizedBox(
            height: 1.h,
          ),
          Observer(
            builder: (BuildContext context) {
              switch (_homeStore.state) {
                case HomeStoreState.loading:
                  return const LottieWidget(lottieType: _constants.lottieLoad);
                case HomeStoreState.loaded:
                  return buildDoctorsDetails();
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildDoctorsDetails() {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Text(
            _constants.personalText,
            style: GoogleFonts.robotoCondensed(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          const Divider(),
          TextInputField(
            controller: _firstNameCtrl,
            label: _constants.firstNameText,
            type: TextInputType.text,
            enabled: _isEdit,
          ),
          TextInputField(
            controller: _lastNameCtrl,
            label: _constants.lastNameText,
            type: TextInputType.text,
            enabled: _isEdit,
          ),
          TextInputField(
            controller: _contactCtrl,
            label: _constants.contactText,
            type: TextInputType.number,
            enabled: false,
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(_constants.dobText),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 25.w,
                      child: TextInputField(
                        controller: _dayCtrl,
                        label: _constants.dayText,
                        enabled: _isEdit,
                        type: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                      child: TextInputField(
                        controller: _monthCtrl,
                        label: _constants.monthText,
                        enabled: _isEdit,
                        type: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                      child: TextInputField(
                        controller: _yearCtrl,
                        label: _constants.yearText,
                        enabled: _isEdit,
                        type: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 25.w,
                  child: TextInputField(
                    controller: _bloodCtrl,
                    label: _constants.bloodText,
                    enabled: _isEdit,
                    type: TextInputType.text,
                  ),
                ),
                SizedBox(
                  width: 25.w,
                  child: TextInputField(
                    controller: _heightCtrl,
                    label: _constants.heightText,
                    enabled: _isEdit,
                    type: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 25.w,
                  child: TextInputField(
                    controller: _weightCtrl,
                    label: _constants.weightText,
                    enabled: _isEdit,
                    type: TextInputType.number,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool> saveChanges() async {
    widget.doctor.edit = true;
    widget.doctor.firstName = _firstNameCtrl.text;
    widget.doctor.lastName = _lastNameCtrl.text;

    if (_dayCtrl.text.isNotEmpty) {
      widget.doctor.day = _dayCtrl.text;
    }

    if (_monthCtrl.text.isNotEmpty) {
      widget.doctor.month = _monthCtrl.text;
    }

    if (_yearCtrl.text.isNotEmpty) {
      widget.doctor.year = _yearCtrl.text;
    }

    if (_bloodCtrl.text.isNotEmpty) {
      widget.doctor.bloodGroup = _bloodCtrl.text;
    }

    if (_heightCtrl.text.isNotEmpty) {
      widget.doctor.height = _heightCtrl.text;
    }

    if (_weightCtrl.text.isNotEmpty) {
      widget.doctor.weight = _weightCtrl.text;
    }

    return await _homeStore.saveDoctor(widget.doctor);
  }
}
