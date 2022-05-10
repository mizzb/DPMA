import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20.w,
        height: 10.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color.fromRGBO(1, 94, 203, 1)),
        ),
        child: const CircularProgressIndicator());
  }
}
