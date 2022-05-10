import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color.fromRGBO(1, 94, 203, 1)),
        ),
        width: 20.w,
        height: 10.h,
        child: const Icon(Icons.error));
  }
}
