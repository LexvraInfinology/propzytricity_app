import 'package:flutter/material.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// Swipeable photo header with dots.
class DetailHero extends StatelessWidget {
  const DetailHero({
    super.key,
    required this.images,
    required this.controller,
    required this.currentIndex,
    required this.onPageChanged,
    required this.onImageTap,
    required this.height,
    this.bottomInset = 40,
  });

  final List<String> images;
  final PageController controller;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onImageTap;
  final double height;

  /// Keeps the dots above the sheet that overlaps the bottom of the photo.
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => onImageTap(i),
              child: AssetPhoto(images[i]),
            ),
          ),
          if (images.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomInset,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < images.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      height: 5,
                      width: i == currentIndex ? 16 : 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: i == currentIndex ? 1 : 0.6,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
