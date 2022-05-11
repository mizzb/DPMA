import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart' as _constants;
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
          border: Border.all(color: _constants.primaryColorDark),
        ),
        child: const CircularProgressIndicator());
  }
}
