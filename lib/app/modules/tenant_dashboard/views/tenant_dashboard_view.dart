import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/enquiries_tab.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/explore_tab.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/home_tab.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/profile_tab.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/saved_tab.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/widgets/app_bottom_nav_bar.dart';

/// App shell: five tabs behind a bottom navigation bar.
class TenantDashboardView extends GetView<TenantDashboardController> {
  const TenantDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tab = controller.currentTab.value;

      return PopScope(
        // Back from any other tab goes to Home first, then leaves the app.
        canPop: tab == TenantDashboardController.homeTab,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) controller.changeTab(TenantDashboardController.homeTab);
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundLight,
          // IndexedStack keeps every tab alive, so scroll position and
          // search text survive tab switches.
          body: IndexedStack(
            index: tab,
            children: const [
              HomeTab(),
              ExploreTab(),
              SavedTab(),
              EnquiriesView(),
              ProfileTab(),
            ],
          ),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: tab,
            onTap: controller.changeTab,
            items: [
              const NavBarItem(
                icon: AppIcons.bottomBarHomeIcon,
                activeIcon: AppIcons.bottomBarHomeFilledIcon,
                label: 'Home',
              ),
              const NavBarItem(
                icon: AppIcons.searchIcon,
                activeIcon: AppIcons.searchFilledIcon,
                label: 'Explore',
              ),
              const NavBarItem(
                icon: AppIcons.favIcon,
                activeIcon: AppIcons.favFilledIcon,
                label: 'Saved',
              ),
              NavBarItem(
                icon: AppIcons.enquriesIcon,
                activeIcon: AppIcons.enquiriesFilledIcon,
                label: 'Enquiries',
                badge: controller.unreadEnquiries.value,
              ),
              const NavBarItem(
                icon: AppIcons.profileIcon,
                activeIcon: AppIcons.profileFilledIcon,
                label: 'Profile',
              ),
            ],
          ),
        ),
      );
    });
  }
}
