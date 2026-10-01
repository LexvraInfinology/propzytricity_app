import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// Full-screen photo viewer: swipe between photos, pinch to zoom.
///
/// ```dart
/// Get.dialog(ImageViewerDialog(images: photos, initialIndex: 2));
/// ```
class ImageViewerDialog extends StatefulWidget {
  const ImageViewerDialog({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  final List<String> images;
  final int initialIndex;

  @override
  State<ImageViewerDialog> createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<ImageViewerDialog> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: Center(
                child: AssetPhoto(widget.images[i], fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            top: topPad + 8,
            right: 16,
            child: IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.close_rounded, color: AppColors.textWhite),
            ),
          ),
          if (widget.images.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomPad + 20,
              child: Center(
                child: Text(
                  '${_index + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: FontFamily.plusJakartaSansMedium,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
