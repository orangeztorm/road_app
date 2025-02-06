// import 'package:beam/cores/__cores.dart';
// import 'package:beam/features/__features.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'user_event.dart';
// part 'user_state.dart';

// // user_bloc.dart
// class UserBloc extends Bloc<UserEvent, UserState> {
//   final AuthRepository authRepository;
//   final UserProfileManager userProfileManager;

//   UserBloc({
//     required this.authRepository,
//     required this.userProfileManager,
//   }) : super(UserState.initial()) {
//     on<GetUser>(_getUser);
//     on<ClearUser>(_clearUser);
//   }

//   // Event handler for fetching the user profile
//   void _getUser(GetUser event, Emitter<UserState> emit) async {
//     // Check if refresh is not requested and profile is already cached
//     if (!event.refresh && userProfileManager.hasProfileCached()) {
//       emit(state.copyWith(
//         status: UserStatus.success,
//         user: userProfileManager.getCachedProfile(),
//       ));
//       return; // No need to fetch from the server again if cached
//     }

//     // If refresh is true or profile is not cached, emit loading state and fetch from server
//     emit(state.copyWith(status: UserStatus.loading));

//     final result = await authRepository.getUserLoginState(const NoParams());

//     result.fold(
//       (failure) {
//         emit(state.copyWith(
//           failures: failure,
//           status: UserStatus.failure,
//         ));
//       },
//       (userProfile) {
//         // Update the UserProfileManager with the newly fetched profile
//         userProfileManager.updateUserProfile(userProfile);
//         emit(state.copyWith(
//           status: UserStatus.success,
//           user: userProfile,
//         ));
//       },
//     );
//   }

//   void _clearUser(ClearUser event, Emitter<UserState> emit) {
//     emit(state.copyWith(status: UserStatus.initial));
//   }
// }
