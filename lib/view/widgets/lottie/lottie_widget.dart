import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  final String? lottieType;
  final double? lottieWidth;
  final int? lottieDuration;

  const LottieWidget({this.lottieType, this.lottieWidth, this.lottieDuration});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (lottieWidth != null)
          ? lottieWidth
          : MediaQuery.of(context).size.width * 0.3,
      child: loadLottie(lottieType, context),
    );
  }

  loadLottie(lottieType, context) {
    switch (lottieType) {
      case 'loading':
        return fetchLottie(context, 'assets/lottie/loading-data.json');
      case 'saving':
        return fetchLottie(context, 'assets/lottie/loading-data.json');
      default:
        return fetchLottie(context, 'assets/lottie/loading-data.json');
    }
  }

  LottieBuilder fetchLottie(context, path) {
    return Lottie.asset(
      path,
      key: UniqueKey(),
      frameBuilder: (context, child, composition) {
        return AnimatedOpacity(
          child: child,
          opacity: 1,
          duration: Duration(
              seconds: (lottieDuration != null) ? lottieDuration! : 120),
        );
      },
    );
  }
}
