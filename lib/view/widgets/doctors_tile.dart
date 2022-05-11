import 'package:dpma/model/doctor.dart';
import 'package:dpma/view/widgets/round_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart' as _constants;

class DoctorsTile extends StatelessWidget {
  const DoctorsTile({
    Key? key,
    required this.doctor,
    required this.onClick,
  }) : super(key: key);

  final Doctor doctor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () => onClick(doctor),
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundImageWidget(
                imageUrl: doctor.profilePic!,
              ),
              const Divider(),
              Text(doctor.firstName! + ' ' + doctor.lastName!,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _constants.primaryColorDark))),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(doctor.specialization!.toString().toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        textStyle:
                        const TextStyle(color: _constants.primaryColor))),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
