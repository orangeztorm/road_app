// import 'package:road_app/cores/__cores.dart';
import 'package:fpdart/fpdart.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

class UserProfileManager {
  Option<UserEntity> _cachedProfile = const Option.none();

  // Check if the profile is already cached
  bool hasProfileCached() {
    return _cachedProfile.isSome();
  }

  // Get the cached profile if available
  UserEntity? getCachedProfile() {
    return _cachedProfile.fold(() => null, (profile) => profile);
  }

  // Update the profile and cache it
  void updateUserProfile(UserEntity userEntity) {
    _cachedProfile = optionOf(userEntity);
  }

  // Clear the cached profile (e.g., on logout)
  void clearUserProfile() {
    _cachedProfile = const Option.none();
    // getIt<UserBloc>().add(const ClearUser());
  }
}
