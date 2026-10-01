import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/data/models/property_model.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/utils/price_formatter.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// Property listing card.
///
/// - Give it a `width` for horizontal lists (home), leave it null to fill the
///   available width (explore).
/// - `enableImagePager` lets the user swipe through photos. Keep it off inside
///   horizontal lists, otherwise the photo swipe fights with the list scroll.
class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.property,
    required this.onTap,
    required this.onFavoriteTap,
    this.width,
    this.imageAspectRatio = 1.55,
    this.enableImagePager = false,
  });

  final PropertyModel property;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final double? width;
  final double imageAspectRatio;
  final bool enableImagePager;

  @override
  Widget build(BuildContext context) {
    final p = property;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.otpBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: imageAspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _PropertyImages(images: p.images, pager: enableImagePager),
                    if (p.isVerified)
                      const Positioned(
                        left: 10,
                        top: 10,
                        child: BadgeChip(
                          label: 'Verified',
                        ),
                      ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: FavoriteButton(
                        selected: p.isFavorite,
                        onTap: onFavoriteTap,
                      ),
                    ),
                    if (p.isNew)
                      const Positioned(
                        right: 10,
                        bottom: 10,
                        child: BadgeChip(
                          label: 'New',
                          textColor: AppColors.textGreen,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: PriceFormatter.rupees(p.pricePerMonth),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.plusJakartaSansBold,
                          color: AppColors.primary,
                        ),
                        children: const [
                          TextSpan(
                            text: ' /month',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: FontFamily.plusJakartaSansRegular,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.plusJakartaSansSemiBold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.textGrey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            p.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: FontFamily.plusJakartaSansRegular,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        PropertyTag('${p.bhk} BHK'),
                        PropertyTag('${PriceFormatter.number(p.areaSqFt)} sq.ft'),
                        PropertyTag(p.furnishing.label),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small white pill over a photo: "Verified", "New".
class BadgeChip extends StatelessWidget {
  const BadgeChip({
    super.key,
    required this.label,
    this.textColor = AppColors.primaryLight,
  });

  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            const AppSvg(AppIcons.verifiedIcon2, size: 13,color: AppColors.primaryLight, ),
            const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontFamily: FontFamily.plusJakartaSansBold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Grey info chip: "3 BHK", "1,650 sq.ft".
class PropertyTag extends StatelessWidget {
  const PropertyTag(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.otpBorderColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontFamily: FontFamily.plusJakartaSansMedium,
          color: AppColors.textGrey,
        ),
      ),
    );
  }
}

/// White circle with a heart.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 32,
          width: 32,
          child: Icon(
            selected ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            size: 18,
            color: selected ? AppColors.error : AppColors.textLightBlack,
          ),
        ),
      ),
    );
  }
}

class _PropertyImages extends StatefulWidget {
  const _PropertyImages({required this.images, required this.pager});

  final List<String> images;
  final bool pager;

  @override
  State<_PropertyImages> createState() => _PropertyImagesState();
}

class _PropertyImagesState extends State<_PropertyImages> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    if (!widget.pager || images.length < 2) {
      return AssetPhoto(images.first);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          itemCount: images.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (context, i) => AssetPhoto(images[i]),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < images.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 2.5),
                  height: 5,
                  width: i == _index ? 14 : 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: i == _index ? 1 : 0.6,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
