import 'package:dpma/model/doctor.dart';
import 'package:dpma/view/widgets/round_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart' as _constants;

class DoctorsList extends StatelessWidget {
  const DoctorsList({
    Key? key,
    required this.doctor,
    required this.onClick,
  }) : super(key: key);

  final Doctor doctor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => onClick(doctor),
          isThreeLine: true,
          leading: RoundImageWidget(
            imageUrl: doctor.profilePic!,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_forward_ios, color: _constants.primaryColorDark),
            ],
          ),
          title: Text(doctor.firstName! + ' ' + doctor.lastName!,
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _constants.primaryColor))),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.7.h),
                child: Text(doctor.specialization!.toString().toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        textStyle:
                            const TextStyle(color: _constants.primaryColor))),
              ),
              Text(doctor.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
