import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// Shared layout for auth screens (OTP, and login if you want to reuse it):
/// a full-screen photo with a rounded sheet sliding over it.
///
/// The photo is as tall as the whole window (not the body), so it does not
/// rescale when the keyboard opens, and nothing shows behind the rounded
/// corners of the sheet.
class AuthSheetScaffold extends StatelessWidget {
  const AuthSheetScaffold({
    super.key,
    required this.child,
    this.image = AppAssets.loginBackground,
    this.heroFraction = 0.40,
    this.overlap = 32,
    this.radius = 50,
  });

  final Widget child;
  final String image;

  /// Visible photo height as a fraction of the screen height.
  final double heroFraction;

  /// How far the sheet slides up over the photo.
  final double overlap;

  /// Top corner radius of the sheet.
  final double radius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    final heroHeight = size.height * heroFraction;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height,
            child: AssetPhoto(image, alignment: Alignment.topCenter),
          ),
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                SizedBox(height: heroHeight - overlap),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: size.height - heroHeight + overlap,
                  ),
                  padding: EdgeInsets.fromLTRB(24, 28, 24, 24 + bottomPad),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius)),
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
