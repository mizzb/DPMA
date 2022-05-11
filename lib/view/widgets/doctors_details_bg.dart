import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorDetailsBG extends StatelessWidget {
  const DoctorDetailsBG({
    Key? key,
    required this.imageLink,
    required this.ctxt,
  }) : super(key: key);

  final dynamic imageLink;
  final BuildContext ctxt;

  @override
  Widget build(BuildContext context) {
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
              height: 90.h,
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
              backgroundImage: (imageLink is String)
                  ? NetworkImage(imageLink)
                  : FileImage(imageLink) as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }
}
