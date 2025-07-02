import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Image imageshow({required String imageUrl, required String imageAsset}) {
  return Image.network(
    imageUrl,
    fit: kIsWeb ? BoxFit.contain : BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress != null) {
        return const Center(
          child: CupertinoActivityIndicator(
            radius: 18.0,
            animating: true,
          ),
        );
      }
      return child;
    },
    errorBuilder: (context, error, stackTrace) {
      return Image.asset(
        imageAsset,
        fit:kIsWeb ? BoxFit.contain : BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    },
  );
}