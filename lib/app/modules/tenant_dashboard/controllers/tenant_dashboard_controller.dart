import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/data/models/app_notification_model.dart';
import 'package:propzytricity/app/data/models/chat_message_model.dart';
import 'package:propzytricity/app/data/models/enquiry_model.dart';
import 'package:propzytricity/app/data/models/locality_model.dart';
import 'package:propzytricity/app/data/models/property_model.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/models/tenant_setup_options.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/chat_view.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/data/tenant_dashboard_mock_data.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/models/tenant_dashboard_filters.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/confirm_dialog.dart';
import 'package:propzytricity/app/routes/app_routes.dart';
import 'package:propzytricity/app/widgets/custom_snackbar.dart';
import 'package:propzytricity/app/widgets/selection_sheet.dart';

/// One controller for the whole tenant dashboard: tab bar, home sections and the
/// explore list (search, filters, sort, favourites).
class TenantDashboardController extends GetxController {
  // ---------------- Shell ----------------
  static const int homeTab = 0;
  static const int exploreTab = 1;

  final currentTab = homeTab.obs;
  final unreadEnquiries = 1.obs;

  void changeTab(int index) => currentTab.value = index;

  // ---------------- User ----------------
  // Integration point: fill from the saved profile / auth response.
  final userName = 'Divyansh'.obs;
  final city = 'Mohali'.obs;

  String get firstName => userName.value.trim().split(' ').first;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  // ---------------- Data ----------------
  final properties = <PropertyModel>[].obs;
  final localities = <LocalityModel>[].obs;

  // ---------------- Explore state ----------------
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  final searchQuery = ''.obs;

  final category = Rxn<PropertyCategory>();
  final budget = Rxn<BudgetFilter>();
  final bhk = Rxn<BhkFilter>();
  final furnishing = Rxn<Furnishing>();
  final verifiedOnly = false.obs;
  final sort = SortOption.relevance.obs;

  final enquiries = <EnquiryModel>[].obs;
  final selectedFilter = EnquiryFilter.all.obs;

  static final filterLabels = EnquiryFilter.values.map((f) => f.label).toList();

  List<EnquiryModel> get filtered => enquiries
      .where((e) => selectedFilter.value.matches(e.status))
      .toList();

  void onFilterSelected(int index) =>
      selectedFilter.value = EnquiryFilter.values[index];

  void onNotificationsTap() {} // TODO
  void onNavTap(int index) {} // TODO: handled by your app shell

  // ---------------- Chat ----------------
  final activeEnquiry = Rxn<EnquiryModel>();
  final messages = <ChatMessageModel>[].obs;

  final inputController = TextEditingController();
  final scrollController = ScrollController();

  // TODO: drive from presence API.
  final lastSeenLabel = 'Last seen 10m ago';

  @override
  void onInit() {
    super.onInit();
    // Integration point: replace with a repository call, e.g.
    // properties.assignAll(await _propertyRepository.getProperties(city.value));
    properties.assignAll(TenantDashboardMock.properties);
    localities.assignAll(TenantDashboardMock.localities);
    enquiries.assignAll(EnquiryModel.samples());
    notifications.assignAll(TenantDashboardMock.notifications);
  }

  // ---------------- Derived lists ----------------
  // Every Rx value is read up-front so Obx always tracks all of them, even
  // when the list is empty.

  List<PropertyModel> get recommended => properties.take(4).toList();

  List<PropertyModel> get recentlyAdded {
    final list = properties.toList()
      ..sort((a, b) => a.addedDaysAgo.compareTo(b.addedDaysAgo));
    return list.take(4).toList();
  }

  List<PropertyModel> get savedProperties =>
      properties.where((p) => p.isFavorite).toList();

  List<PropertyModel> get filteredProperties {
    final all = properties.toList();
    final query = searchQuery.value.trim().toLowerCase();
    final categoryFilter = category.value;
    final budgetFilter = budget.value;
    final bhkFilter = bhk.value;
    final furnishingFilter = furnishing.value;
    final onlyVerified = verifiedOnly.value;
    final sortOption = sort.value;

    final result = all.where((p) {
      if (categoryFilter != null && p.category != categoryFilter) return false;
      if (budgetFilter != null && !budgetFilter.matches(p.pricePerMonth)) {
        return false;
      }
      if (bhkFilter != null && !bhkFilter.matches(p.bhk)) return false;
      if (furnishingFilter != null && p.furnishing != furnishingFilter) {
        return false;
      }
      if (onlyVerified && !p.isVerified) return false;
      if (query.isNotEmpty &&
          !'${p.title} ${p.location}'.toLowerCase().contains(query)) {
        return false;
      }
      return true;
    }).toList();

    switch (sortOption) {
      case SortOption.relevance:
        break;
      case SortOption.priceLowToHigh:
        result.sort((a, b) => a.pricePerMonth.compareTo(b.pricePerMonth));
      case SortOption.priceHighToLow:
        result.sort((a, b) => b.pricePerMonth.compareTo(a.pricePerMonth));
      case SortOption.newest:
        result.sort((a, b) => a.addedDaysAgo.compareTo(b.addedDaysAgo));
    }
    return result;
  }

  // ---------------- Favourites ----------------

  void toggleFavorite(PropertyModel property) {
    final index = properties.indexWhere((p) => p.id == property.id);
    if (index == -1) return;
    final current = properties[index];
    properties[index] = current.copyWith(isFavorite: !current.isFavorite);
  }

  // ---------------- Navigation helpers ----------------

  void openExplore() => changeTab(exploreTab);

  void openCategory(PropertyCategory value) {
    category.value = value;
    changeTab(exploreTab);
  }

  void openLocality(LocalityModel locality) {
    searchController.text = locality.name;
    searchQuery.value = locality.name;
    changeTab(exploreTab);
  }

  /// Home search bar is only a button: jump to Explore and open the keyboard.
  void focusSearch() {
    changeTab(exploreTab);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocus.requestFocus();
    });
  }

  void openProperty(PropertyModel property) {
  Get.toNamed(AppRoutes.propertyDetails);
    // CustomSnackbar.info('Property details will be available soon');
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
    // CustomSnackbar.info('Notifications will be available soon');
  }

  void openMap() {
    CustomSnackbar.info('Map view will be available soon');
  }

  // ---------------- Search + filters ----------------

  void onSearchChanged(String value) => searchQuery.value = value;

  void selectCategory(PropertyCategory? value) => category.value = value;

  void toggleVerifiedOnly() => verifiedOnly.value = !verifiedOnly.value;

  bool get hasActiveFilters =>
      searchQuery.value.trim().isNotEmpty ||
      category.value != null ||
      budget.value != null ||
      bhk.value != null ||
      furnishing.value != null ||
      verifiedOnly.value;

  void clearFilters() {
    searchController.clear();
    searchQuery.value = '';
    category.value = null;
    budget.value = null;
    bhk.value = null;
    furnishing.value = null;
    verifiedOnly.value = false;
  }

  Future<void> pickCity() async {
    final result = await showSelectionSheet<String>(
      title: 'Select city',
      options: TenantDashboardMock.cities,
      labelOf: (c) => c,
      selected: city.value,
    );
    final value = result?.value;
    if (value != null) city.value = value;
  }

  Future<void> pickBudget({bool goToExplore = false}) => _pick<BudgetFilter>(
        title: 'Budget (per month)',
        options: BudgetFilter.values,
        labelOf: (e) => e.label,
        target: budget,
        goToExplore: goToExplore,
      );

  Future<void> pickBhk({bool goToExplore = false}) => _pick<BhkFilter>(
        title: 'BHK',
        options: BhkFilter.values,
        labelOf: (e) => e.label,
        target: bhk,
        goToExplore: goToExplore,
      );

  Future<void> pickFurnishing({bool goToExplore = false}) => _pick<Furnishing>(
        title: 'Furnishing',
        options: Furnishing.values,
        labelOf: (e) => e.label,
        target: furnishing,
        goToExplore: goToExplore,
      );

  Future<void> pickCategory({bool goToExplore = false}) =>
      _pick<PropertyCategory>(
        title: 'Property type',
        options: PropertyCategory.values,
        labelOf: (e) => e.label,
        target: category,
        goToExplore: goToExplore,
      );

  Future<void> pickSort() async {
    final result = await showSelectionSheet<SortOption>(
      title: 'Sort by',
      options: SortOption.values,
      labelOf: (e) => e.label,
      selected: sort.value,
    );
    final value = result?.value;
    if (value != null) sort.value = value;
  }

  Future<void> _pick<T>({
    required String title,
    required List<T> options,
    required String Function(T option) labelOf,
    required Rxn<T> target,
    bool goToExplore = false,
  }) async {
    final result = await showSelectionSheet<T>(
      title: title,
      options: options,
      labelOf: labelOf,
      selected: target.value,
      clearLabel: 'Any',
    );
    if (result == null) return;

    target.value = result.value;
    if (goToExplore) changeTab(exploreTab);
  }

  /// Sets the active enquiry and opens the chat screen.
  /// Same controller instance is reused (no separate binding needed).
  /// Swap Get.to with Get.toNamed(AppRoutes.chat) if you use named routes
  /// (and give that route binding: EnquiriesBinding()).
  void openChat(EnquiryModel enquiry) {
    activeEnquiry.value = enquiry;
    inputController.clear();
    // TODO: load history by enquiry.id / subscribe to socket stream.
    messages.assignAll(ChatMessageModel.samples());
    Get.to(() => const ChatView());
  }

  void sendMessage() {
    final text = inputController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    messages.add(
      ChatMessageModel(
        id: now.microsecondsSinceEpoch.toString(),
        text: text,
        sentAt: now,
        isMine: true,
      ),
    );
    inputController.clear();
    _scrollToBottom();
    // TODO: send via API / socket.
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void onAttachTap() {} // TODO: image / file picker
  void onMoreTap() {} // TODO: block / report menu
  void onPropertyTap() {} // TODO: open property detail

  // ---------------- Profile ----------------
  // Integration point: load these from the profile API and save them back
  // in saveProfile().
  static const String appVersion = 'v1.0.0';

  final userEmail = 'abhigill@gmail.com'.obs;
  final userPhone = '9876543210'.obs;
  final userAbout =
      'Looking for a 2–3 BHK apartment in Mohali or Zirakpur with good connectivity and modern amenities.'
          .obs;
  final profileLocation = 'Mohali, Punjab'.obs;
  final lookingFor = PropertyInterest.rent.obs;
  final preferredType = PropertyCategory.apartment.obs;
  final avatarPath = RxnString();

  String get formattedPhone {
    final phone = userPhone.value;
    return phone.length == 10
        ? '+91 ${phone.substring(0, 5)} ${phone.substring(5)}'
        : '+91 $phone';
  }

  // ---------------- Edit profile form ----------------
  static const int aboutMaxLength = 200;
  static final RegExp _phoneRegex = RegExp(r'^[6-9]\d{9}$');

  final editNameController = TextEditingController();
  final editPhoneController = TextEditingController();
  final editAboutController = TextEditingController();
  final editLocation = RxnString();
  final editLookingFor = Rxn<PropertyInterest>();
  final editType = Rxn<PropertyCategory>();
  final editNameError = RxnString();
  final editPhoneError = RxnString();
  final isSavingProfile = false.obs;

  /// Fills the form with the current profile, then opens the screen.
  void openEditProfile() {
    editNameController.text = userName.value;
    editPhoneController.text = userPhone.value;
    editAboutController.text = userAbout.value;
    editLocation.value = profileLocation.value;
    editLookingFor.value = lookingFor.value;
    editType.value = preferredType.value;
    editNameError.value = null;
    editPhoneError.value = null;
    Get.toNamed(AppRoutes.editProfile);
  }

  void onEditNameChanged(String _) {
    if (editNameError.value != null) editNameError.value = null;
  }

  void onEditPhoneChanged(String _) {
    if (editPhoneError.value != null) editPhoneError.value = null;
  }

  void changePhoto() {
    // Integration point: image_picker + upload, then set avatarPath.
    CustomSnackbar.info('Photo upload will be available soon');
  }

  Future<void> saveProfile() async {
    if (isSavingProfile.value) return;
    FocusManager.instance.primaryFocus?.unfocus();

    var valid = true;
    if (editNameController.text.trim().length < 2) {
      editNameError.value = 'Enter your full name';
      valid = false;
    }
    if (!_phoneRegex.hasMatch(editPhoneController.text.trim())) {
      editPhoneError.value = 'Enter a valid 10-digit mobile number';
      valid = false;
    }
    if (!valid) return;

    isSavingProfile.value = true;
    try {
      // Integration point: await _profileRepository.updateProfile(...);
      await Future<void>.delayed(const Duration(seconds: 1));

      userName.value = editNameController.text.trim();
      userPhone.value = editPhoneController.text.trim();
      userAbout.value = editAboutController.text.trim();
      profileLocation.value = editLocation.value ?? profileLocation.value;
      city.value = profileLocation.value.split(',').first.trim();
      lookingFor.value = editLookingFor.value ?? lookingFor.value;
      preferredType.value = editType.value ?? preferredType.value;

      CustomSnackbar.success('Profile updated');
      Get.back();
    } catch (_) {
      CustomSnackbar.error('Could not save your profile. Please try again.');
    } finally {
      isSavingProfile.value = false;
    }
  }




  // ---------------- Settings rows ----------------

  void comingSoon(String feature) {
    CustomSnackbar.info('$feature will be available soon');
  }

  Future<void> confirmLogout() async {
    final confirmed = await showConfirmDialog(
      icon: Icons.logout_rounded,
      title: 'Are you sure you want to log out?',
      message:
      'You can always log in again to access your saved properties, enquiries and preferences.',
      confirmText: 'Log Out',
    );
    if (!confirmed) return;

    // Integration point: call the logout API and clear the saved token and
    // user data before leaving.
    Get.offAllNamed(AppRoutes.login);
  }
  // ---------------- Notifications ----------------
  final notifications = <AppNotification>[].obs;
  final notificationFilter = NotificationFilter.all.obs;

  /// Areas the alerts are about (shown on the right of the TODAY heading).
  static const String notificationAreas = 'Mohali & Zirakpur';

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  List<AppNotification> get visibleNotifications {
    final filter = notificationFilter.value;
    return notifications.where((n) => filter.matches(n.type)).toList()
      ..sort((a, b) => a.age.compareTo(b.age));
  }

  void selectNotificationFilter(NotificationFilter filter) =>
      notificationFilter.value = filter;

  void openNotification(AppNotification notification) {
    final index = notifications.indexWhere((n) => n.id == notification.id);
    if (index != -1 && !notifications[index].isRead) {
      notifications[index] = notifications[index].copyWith(isRead: true);
    }
    if (notification.actionLabel != null) comingSoon('Chat');
  }

  // ---------------- Location preferences ----------------
  // Integration point: load/save the chosen areas through the profile API.
  static const List<String> knownAreas = [
    'Sector 66, Mohali',
    'Sector 67, Mohali',
    'Sector 68, Mohali',
    'Sector 69, Mohali',
    'Sector 70, Mohali',
    'Sector 71, Mohali',
    'Aerocity, Mohali',
    'Zirakpur',
    'Kharar',
  ];

  final selectedAreas = <String>[
    'Sector 67, Mohali',
    'Sector 70, Mohali',
    'Kharar',
  ].obs;
  final areaSearchController = TextEditingController();
  final areaQuery = ''.obs;

  /// Areas that can still be added (not selected, and matching the search).
  List<String> get availableAreas {
    final query = areaQuery.value.trim().toLowerCase();
    final chosen = selectedAreas.toList();
    return knownAreas
        .where(
          (a) =>
      !chosen.contains(a) &&
          (query.isEmpty || a.toLowerCase().contains(query)),
    )
        .toList();
  }

  void onAreaSearchChanged(String value) => areaQuery.value = value;

  void addArea(String area) {
    if (!selectedAreas.contains(area)) selectedAreas.add(area);
  }

  void removeArea(String area) => selectedAreas.remove(area);

  // ---------------- Profile sub-pages ----------------

  void openLocationPreferences() {
    areaSearchController.clear();
    areaQuery.value = '';
    Get.toNamed(AppRoutes.locationPreferences);
  }

  void openHelpSupport() => Get.toNamed(AppRoutes.helpSupport);

  void openTerms() => Get.toNamed(AppRoutes.termsConditions);

  void openPrivacy() => Get.toNamed(AppRoutes.privacyPolicy);

  void openAbout() => Get.toNamed(AppRoutes.about);

  @override
  void onClose() {
    searchController.dispose();
    searchFocus.dispose();
    inputController.dispose();
    scrollController.dispose();
    searchFocus.dispose();
    areaSearchController.dispose();
    editNameController.dispose();
    editPhoneController.dispose();
    editAboutController.dispose();
    super.onClose();
  }
}
