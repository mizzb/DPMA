import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpma/view/widgets/placeholder_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart' as _constants;
import 'error_image.dart';

class RoundImageWidget extends StatelessWidget {
  const RoundImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: 20.w,
        height: 10.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _constants.primaryColorDark),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => const PlaceHolderImage(),
      errorWidget: (context, url, error) => const ErrorImage(),
    );
  }
}
