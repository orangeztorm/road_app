// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class DetectPotholeCubit extends Cubit<DetectPotholeFormzState> {
  DetectPotholeCubit() : super(DetectPotholeFormzState.initial());

  // fuction call

  // void DetectPotholeUser(DetectPotholeBloc bloc) {
  //   bloc.add(DetectPothole(state));
  // }

  void updateImage(File? image) {
    emit(state.copyWith(image: image));
  }

  void updateLng(num? lng) {
    emit(state.copyWith(lng: lng));
  }

  void updateLat(num? lat) {
    emit(state.copyWith(lat: lat));
  }

  void updateAddress(String? address) {
    emit(state.copyWith(address: address));
  }

  void navigateToDashBoard() {
    // userProfileManager.clearUserProfile();
    // Future.delayed(const Duration(seconds: 1), () {
    //   AppRouter.instance.clearRouteAndPush(DashboardPage.routeName);
    //   userBloc.add(const GetUser());
    // });
    // reset();
  }

  void navigateToLoginOnError() {
    // userProfileManager.clearUserProfile();
    // AppRouter.instance.clearRouteAndPush(LoginPhoneScreen.routeName);
    // Toast.showError("An error occured");
  }

  void navigateToPinScreen() {
    // state.copyWith(pin: const RequiredLength.pure(minLength: 6));
    // AppRouter.instance.navigateTo(LoginPinScreen.routeName);
  }

  void reset() {
    emit(DetectPotholeFormzState.initial());
  }
}

class DetectPotholeFormzState extends RequestParam {
  final File? image;
  final num? lng;
  final num? lat;
  final String? address;

  const DetectPotholeFormzState({
    this.image,
    this.lng,
    this.lat,
    this.address,
  });

  factory DetectPotholeFormzState.initial() {
    return const DetectPotholeFormzState();
  }

  DetectPotholeFormzState copyWith({
    File? image,
    num? lng,
    num? lat,
    String? address,
  }) {
    return DetectPotholeFormzState(
      image: image ?? this.image,
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
      address: address ?? this.address,
    );
  }

  bool get isValid => image != null && lng != null && lat != null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'longitude': lng,
      'latitude': lat,
      'address': address,
    };
  }

  // Convert XFile fields to Multipart entries
  Future<List<MapEntry<String, http.MultipartFile>>> toFileMapEntries() async {
    List<MapEntry<String, http.MultipartFile>> fileEntries = [];

    if (image != null) {
      fileEntries.add(await toFileMapEntry(image!, 'imagessss'));
    }

    return fileEntries;
  }

  @override
  List<Object?> get props => [
        image,
        lng,
        lat,
        address,
      ];
}

// Helper method to convert an XFile to a Multipart file
Future<MapEntry<String, http.MultipartFile>> toFileMapEntry(
    File file, String fieldName) async {
  final mimeTypeData = lookupMimeType(file.path)?.split('/');
  final fileMultipart = await http.MultipartFile.fromPath(
    fieldName,
    file.path,
    filename: basename(file.path),
    contentType: mimeTypeData != null
        ? MediaType(mimeTypeData[0], mimeTypeData[1])
        : null,
  );
  return MapEntry(fieldName, fileMultipart);
}
