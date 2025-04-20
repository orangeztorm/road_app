// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/cores/components/search_widget.dart';
import 'package:road_app/features/road_app/data/responses/admin/places_response.dart';
import 'package:road_app/features/road_app/presentation/pages/user/map_page.dart';
// import 'package:road_app/features/road_app/presentation/pages/user/map_page.dart';
import 'package:road_app/features/road_app/presentation/pages/user/mapbox_map.dart';

class LocationSearchView extends StatelessWidget {
  static const routeName = '/location_search_view';
  const LocationSearchView({super.key, this.onTap});

  final void Function(SearchFieldListItem<dynamic>?)? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
      ),
      useSingleScroll: false,
      body: Column(
        children: [
          const VSpace(),
          Expanded(
            child: _AddressListForm(
              onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressListForm extends StatefulWidget {
  final void Function(SearchFieldListItem<dynamic>?)? onTap;
  const _AddressListForm(
    this.onTap,
  );

  @override
  State<_AddressListForm> createState() => _AddressListFormState();
}

class _AddressListFormState extends State<_AddressListForm> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Column(
            children: [
              PlaceSearchWidget(
                controller: _searchController,
                usePrefix: true,
                useSuffix: true,
                iconSuffix: InkWell(
                  onTap: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                ),
                submitAction: (e) async {
                  final searchResult = e?.searchKey as String;
                  final item = e?.item as PlaceDetailResult?;
                  debugPrint('e: $searchResult');
                  debugPrint('e: $item');
                  _searchController.text = searchResult;
                  widget.onTap?.call(e);
                  // Navigator.pop(context);
                  // AppRouter.instance.navigateToAndReplacePage(MapScreen(
                  //   destination: LatLng(
                  //     item?.result?.geometry?.location?.lat ?? 0.0,
                  //     item?.result?.geometry?.location?.lng ?? 0.0,
                  //   ),
                  //   destinationAddress: item?.result?.formattedAddress ?? '',
                  // ));
                  AppRouter.instance
                      .navigateToAndReplacePage(MapboxPotholeScreen(
                    destination: LatLng(
                      item?.result?.geometry?.location?.lat ?? 0.0,
                      item?.result?.geometry?.location?.lng ?? 0.0,
                    ),
                    // destinationAddress: item?.result?.formattedAddress ?? '',
                  ));
                },
              ),
              const Spacer(),
            ],
          ),
        )
      ],
    );
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    AppLock.of(context)?.setEnabled(false);

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    AppLock.of(context)?.setEnabled(true);

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final value = await Geolocator.getCurrentPosition();
    getAddressFromLatLng(value.latitude, value.longitude);
  }

  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      // Get a list of placemarks based on the latitude and longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        // Take the first placemark
        Placemark place = placemarks[0];

        // Construct an address using the placemark's properties
        String address =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';

        // final UpgradeTierOneCubit cubit = getIt<UpgradeTierOneCubit>();
        // cubit.updateLocationDetails(
        //     LocationDetails(address: address, lat: latitude, lng: longitude));
        Navigator.of(context).pop();
      }
    } catch (e) {
      Toast.showError('Error getting location');
    }
  }
}

class SmallMapPreview extends StatefulWidget {
  final LatLng location;
  final void Function(LatLng)? onMapTap; // Function to handle map tap

  const SmallMapPreview({super.key, required this.location, this.onMapTap});

  @override
  State<SmallMapPreview> createState() => _SmallMapPreviewState();
}

class _SmallMapPreviewState extends State<SmallMapPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Small size preview
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.kcPrimaryColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          mapToolbarEnabled: false,
          compassEnabled: false,
          initialCameraPosition: CameraPosition(
            target: widget.location,
            zoom: 16, // Adjust zoom level for a small preview
          ),
          markers: {
            Marker(
              markerId: const MarkerId('storeLocation'),
              position: widget.location,
            ),
          },
          zoomGesturesEnabled: false, // Disable gestures for small preview
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          myLocationEnabled: false,
          onTap: widget.onMapTap != null
              ? (_) =>
                  widget.onMapTap!(widget.location) // Pass the location on tap
              : null,
        ),
      ),
    );
  }
}
