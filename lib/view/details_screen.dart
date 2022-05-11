import 'package:dpma/controller/home_store.dart';
import 'package:dpma/model/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
  bool isEdit = false;
  final HomeStore _homeStore = locator.get<HomeStore>();

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
      backgroundColor: const Color.fromRGBO(47, 87, 159, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              DoctorDetailsBG(
                imageLink: widget.doctor.profilePic!,
                context: context,
              ),
              buildDetails()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildDetails() {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10.h + 20.w,
          ),
          Text(
            widget.doctor.firstName! + ' ' + widget.doctor.lastName!,
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoCondensed(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),

          ElevatedButton(
              onPressed: () async {
                if (!isEdit) {
                  setState(() {
                    isEdit = true;
                  });
                } else {
                  bool resp = await saveChanges();
                  if(resp){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes Saved')));
                    setState(() {
                      isEdit = false;
                    });
                  }
                }
              },
              child: (isEdit)
                  ? const Text('SAVE CHANGES')
                  : const Text('EDIT PROFILE')),

          SizedBox(
            height: 1.h,
          ),

          Container(
            width: 90.w,
            height: 50.h,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'PERSONAL DETAILS',
                    style: GoogleFonts.robotoCondensed(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const Divider(),
                  TextInputField(
                    controller: _firstNameCtrl,
                    label: 'First Name',
                    enabled: isEdit,
                  ),
                  TextInputField(
                    controller: _lastNameCtrl,
                    label: 'Last Name',
                    enabled: isEdit,
                  ),
                  TextInputField(
                    controller: _contactCtrl,
                    label: 'Contact Number',
                    enabled: false,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Date of birth'),
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
                                label: 'Day',
                                enabled: isEdit,
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                              child: TextInputField(
                                controller: _monthCtrl,
                                label: 'Month',
                                enabled: isEdit,
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                              child: TextInputField(
                                controller: _yearCtrl,
                                label: 'Year',
                                enabled: isEdit,
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
                            label: 'Blood Group',
                            enabled: isEdit,
                          ),
                        ),
                        SizedBox(
                          width: 25.w,
                          child: TextInputField(
                            controller: _heightCtrl,
                            label: 'Height',
                            enabled: isEdit,
                          ),
                        ),
                        SizedBox(
                          width: 25.w,
                          child: TextInputField(
                            controller: _weightCtrl,
                            label: 'Weight',
                            enabled: isEdit,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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

class DoctorDetailsBG extends StatelessWidget {
  const DoctorDetailsBG({
    Key? key,
    required this.imageLink,
    required this.context,
  }) : super(key: key);

  final String imageLink;
  final BuildContext context;

  @override
  Widget build(BuildContext ctxt) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 10.h,
            ),
            Container(
              width: 100.w,
              height: 90.h -
                  MediaQuery.of(context).padding.top -
                  AppBar().preferredSize.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10.h - 15.w,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 5)),
            child: CircleAvatar(
              radius: 15.w,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(imageLink),
            ),
          ),
        ),
      ],
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.enabled,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 14)),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0),
            ),
            label: Text(label),
            labelStyle:
                GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
            filled: true,
            contentPadding:
                const EdgeInsets.only(left: 0.0, bottom: 0.0, top: 0.0),
            fillColor: Colors.white),
      ),
    );
  }
}
