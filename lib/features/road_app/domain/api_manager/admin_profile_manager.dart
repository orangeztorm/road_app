import 'package:fpdart/fpdart.dart';
import 'package:road_app/features/__features.dart';

class AdminProfileManager {
  Option<AdminProfileEntity> _cachedProfile = const Option.none();

  // Check if the profile is already cached
  bool hasProfileCached() {
    return _cachedProfile.isSome();
  }

  // Get the cached profile if available
  AdminProfileEntity? getCachedProfile() {
    return _cachedProfile.fold(() => null, (profile) => profile);
  }

  // Update the profile and cache it
  void updateUserProfile(AdminProfileEntity userEntity) {
    _cachedProfile = optionOf(userEntity);
  }

  // Clear the cached profile (e.g., on logout)
  void clearUserProfile() {
    _cachedProfile = const Option.none();
    // getIt<>().add(const ClearUser());
  }

  // Helper methods to retrieve specific information from the cached profile

  // String? get email =>
  //     _cachedProfile.fold(() => null, (profile) => profile.user?.email);

  // String? get name =>
  //     _cachedProfile.fold(() => null, (profile) => profile.user?.firstName);

  AdminProfileEntity? get userData {
    return _cachedProfile.fold(() => null, (profile) => profile);
  }
}
