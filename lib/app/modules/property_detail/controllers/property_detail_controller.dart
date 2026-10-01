import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/data/models/property_detail_model.dart';
import 'package:propzytricity/app/data/models/property_model.dart';
import 'package:propzytricity/app/data/models/subscription_plan_model.dart';
import 'package:propzytricity/app/modules/property_detail/data/property_detail_mock_data.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/image_viewer_dialog.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/data/tenant_dashboard_mock_data.dart';
import 'package:propzytricity/app/routes/app_routes.dart';
import 'package:propzytricity/app/services/subscription_service.dart';
import 'package:propzytricity/app/widgets/custom_snackbar.dart';

/// One controller for the property detail page and the Choose Plan page
/// (both live in this module and share this instance via the binding).
class PropertyDetailController extends GetxController {
  // ---------------- Subscription ----------------
  late final SubscriptionService subscription = Get.find<SubscriptionService>();

  List<SubscriptionPlan> get plans => SubscriptionService.plans;
  bool get hasPlan => subscription.hasActivePlan;

  final subscribingPlanId = RxnString();

  // ---------------- Detail page state ----------------
  final detail = Rxn<PropertyDetailModel>();
  final isFavorite = false.obs;

  final scrollController = ScrollController();
  final heroController = PageController();
  final heroIndex = 0.obs;
  final activeTab = 0.obs;

  final amenitiesExpanded = false.obs;
  final photosExpanded = false.obs;

  // Section anchors for the Photos / Floor Plan / Map tabs.
  final photosKey = GlobalKey();
  final floorPlanKey = GlobalKey();
  final mapKey = GlobalKey();

  TenantDashboardController? get _dashboard =>
      Get.isRegistered<TenantDashboardController>()
          ? Get.find<TenantDashboardController>()
          : null;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    loadProperty(
      args is PropertyModel ? args : TenantDashboardMock.properties.first,
    );
  }

  /// Shows [property] on the page. Also used when the user taps a similar
  /// property, so the page updates in place (a second route would reuse this
  /// same controller instance).
  void loadProperty(PropertyModel property) {
    // Integration point: fetch the real detail, e.g.
    // detail.value = await _propertyRepository.getDetail(property.id);
    detail.value = PropertyDetailMock.forProperty(property);
    isFavorite.value = property.isFavorite;

    heroIndex.value = 0;
    activeTab.value = 0;
    amenitiesExpanded.value = false;
    photosExpanded.value = false;

    if (heroController.hasClients) heroController.jumpToPage(0);
    if (scrollController.hasClients) scrollController.jumpTo(0);
  }

  // ---------------- Similar properties ----------------

  List<PropertyModel> get similarProperties {
    final currentId = detail.value?.property.id;
    final source =
        _dashboard?.properties.toList() ?? TenantDashboardMock.properties;
    return source.where((p) => p.id != currentId).take(4).toList();
  }

  void openSimilar(PropertyModel property) => loadProperty(property);

  void seeAllSimilar() => Get.back();

  // ---------------- Favourites ----------------

  void toggleFavorite() {
    final property = detail.value?.property;
    if (property != null) toggleFavoriteOf(property);
  }

  void toggleFavoriteOf(PropertyModel property) {
    final dashboard = _dashboard;
    dashboard?.toggleFavorite(property);

    if (property.id == detail.value?.property.id) {
      isFavorite.value = dashboard == null
          ? !isFavorite.value
          : dashboard.properties
              .firstWhere((p) => p.id == property.id, orElse: () => property)
              .isFavorite;
    }
  }

  // ---------------- Hero / tabs / sections ----------------

  void onHeroChanged(int index) => heroIndex.value = index;

  void selectTab(int index) {
    activeTab.value = index;
    switch (index) {
      case 0:
        _scrollTo(photosKey);
      case 1:
        CustomSnackbar.info('Video tour will be available soon');
      case 2:
        _scrollTo(floorPlanKey);
      case 3:
        _scrollTo(mapKey);
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      alignment: 0.05,
    );
  }

  void toggleAmenities() => amenitiesExpanded.value = !amenitiesExpanded.value;

  void togglePhotos() => photosExpanded.value = !photosExpanded.value;

  void openImages(List<String> images, int index) {
    Get.dialog(
      ImageViewerDialog(images: images, initialIndex: index),
      useSafeArea: false,
    );
  }

  void openFloorPlan() {
    final plan = detail.value?.floorPlanImage;
    if (plan != null) openImages([plan], 0);
  }

  void openMap() {
    // Integration point: open Google Maps with the property coordinates.
    CustomSnackbar.info('Map view will be available soon');
  }

  void share() {
    // Integration point: share_plus with the property link.
    CustomSnackbar.info('Sharing will be available soon');
  }

  // ---------------- Contact owner ----------------

  void openChoosePlan() => Get.toNamed(AppRoutes.choosePlan);

  void enquire() {
    if (!hasPlan) {
      openChoosePlan();
      return;
    }
    // Integration point: create the enquiry (and spend a credit) via the API.
    CustomSnackbar.success('Enquiry sent to the owner');
  }

  void callOwner() {
    if (!hasPlan) {
      openChoosePlan();
      return;
    }
    // Integration point: unlock the number via the API, then open the dialer
    // with url_launcher (tel:).
    CustomSnackbar.info('Calling the owner will be available soon');
  }

  // ---------------- Plans ----------------

  Future<void> subscribe(SubscriptionPlan plan) async {
    if (subscribingPlanId.value != null) return;

    subscribingPlanId.value = plan.id;
    try {
      // Integration point: start the payment (Razorpay etc.), verify it on
      // the backend, then activate the plan.
      await Future<void>.delayed(const Duration(milliseconds: 1200));

      subscription.activate(plan);
      CustomSnackbar.success('${plan.name} activated');
      Get.back();
    } catch (_) {
      CustomSnackbar.error('Payment failed. Please try again.');
    } finally {
      subscribingPlanId.value = null;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    heroController.dispose();
    super.onClose();
  }
}
