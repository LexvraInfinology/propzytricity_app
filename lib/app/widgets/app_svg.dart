import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg extends StatelessWidget {
  const AppSvg(
      this.asset, {
        super.key,
        this.size,
        this.width,
        this.height,
        this.color,
        this.fit = BoxFit.contain,
      });

  final String asset;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final w = width ?? size;
    final h = height ?? size;

    final svg = SvgPicture.asset(
      asset,
      width: w,
      height: h,
      fit: fit,
      colorFilter:
      color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );

    if (w == null && h == null) return svg;

    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: svg,
    );
  }
}