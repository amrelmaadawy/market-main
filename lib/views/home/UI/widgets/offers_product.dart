import 'package:app/core/app_colors.dart';
import 'package:app/core/components/cashed_loading_image.dart';
import 'package:flutter/material.dart';

class OffersProduct extends StatelessWidget {
  const OffersProduct({
    super.key,
    required this.imageUrl,
    required this.offer,
  });
  final String imageUrl;
  final String offer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: CashedLoadingWidget(imageUrl: imageUrl),
        ),
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "OFF $offer %",
                style: TextStyle(
                  color: AppColors.kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
