import 'package:app/core/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashedLoadingWidget extends StatelessWidget {
  const CashedLoadingWidget({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const SizedBox(
          height: 250,
          width: double.infinity,
          child: Center(
              child: CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          ))),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
