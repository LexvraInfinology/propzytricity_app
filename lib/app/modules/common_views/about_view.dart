import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/custom_snackbar.dart';

/// Static page: no controller. Every widget it uses lives in this file.
class AboutView extends StatelessWidget {
  const AboutView({super.key});

  // Integration point: read the real version with package_info_plus.
  static const String _version = '1.0.0';

  static const String _description =
      'PROPZY TRICITY is your trusted real estate platform to discover, rent, '
      'and buy properties in Mohali, Chandigarh and Panchkula. We aim to make '
      'property search simple, transparent and reliable for everyone.';

  static const String _email = 'support@propzytricity.com';
  static const String _phone = '+91 98765 43210';
  static const String _website = 'www.propzytricity.com';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: 'About PROPZY TRICITY'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, 28, 24, 32),
                child: Column(
                  children: [
                    _Logo(),
                    SizedBox(height: 14),
                    Text(
                      'PROPZY TRICITY',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.6,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Version $_version',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: FontFamily.plusJakartaSansRegular,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      _description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.55,
                        fontFamily: FontFamily.plusJakartaSansRegular,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 24),
                    _InfoCard(
                      icon: Icons.auto_awesome_outlined,
                      title: 'Our Mission',
                      subtitle: 'To simplify real estate for everyone.',
                    ),
                    SizedBox(height: 10),
                    _InfoCard(
                      icon: Icons.visibility_outlined,
                      title: 'Our Vision',
                      subtitle: 'To be the most trusted property platform in Tricity.',
                    ),
                    SizedBox(height: 28),
                    _ContactCard(
                      icon: Icons.call_outlined,
                      title: 'Contact Us',
                      lines: [_email, _phone],
                    ),
                    SizedBox(height: 10),
                    _ContactCard(
                      icon: Icons.language_rounded,
                      title: 'Visit Website',
                      lines: [_website],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Row(
        children: [
          Material(
            color: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(color: AppColors.otpBorderColor),
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: Get.back,
              child: const SizedBox(
                height: 44,
                width: 44,
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: FontFamily.plusJakartaSansBold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
          ),
          // Keeps the title centred.
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

/// Green rounded square with the house icon.
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Center(child: AppSvg(AppIcons.home, size: 30, color: AppColors.textWhite)),
    );
  }
}

/// Shared look of the white cards on this page.
class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.otpBorderColor),
      ),
      child: child,
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 14, color: AppColors.primary),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Row(
        children: [
          _IconBadge(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: FontFamily.plusJakartaSansBold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: FontFamily.plusJakartaSansRegular,
                    color: AppColors.textGrey,
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

/// Title with one or more green lines. Tapping a line copies it.
/// (Add url_launcher later to open the mail app, dialer or browser.)
class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.lines,
  });

  final IconData icon;
  final String title;
  final List<String> lines;

  Future<void> _copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    CustomSnackbar.info('Copied to clipboard');
  }

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBadge(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: FontFamily.plusJakartaSansSemiBold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                for (final line in lines)
                  GestureDetector(
                    onTap: () => _copy(line),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        line,
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: FontFamily.plusJakartaSansMedium,
                          color: AppColors.primaryLight,
                        ),
                      ),
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