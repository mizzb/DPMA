import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart' as _constants;
class ErrorImage extends StatelessWidget {
  const ErrorImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _constants.primaryColorDark),
        ),
        width: 20.w,
        height: 10.h,
        child: const Icon(Icons.error, color: _constants.primaryColorDark,));
  }
}
