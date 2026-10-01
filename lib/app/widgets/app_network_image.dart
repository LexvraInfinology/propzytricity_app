import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.width,
    this.height,
  });

  final String url;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: AppColors.primaryLight.withValues(alpha: 0.06),
      child: Icon(
        Icons.image_outlined,
        color: AppColors.textGrey.withValues(alpha: 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : _placeholder(),
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      ),
    );
  }
}
