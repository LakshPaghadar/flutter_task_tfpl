import 'dart:async';

import 'package:dummy_api_call_retrofit/screens/app_lang/app_db.dart';
import 'package:dummy_api_call_retrofit/screens/model/geofencing_location.dart';
import 'package:dummy_api_call_retrofit/screens/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../generated/l10n.dart';
import '../values/colors.dart';
import '../values/style.dart';
import 'widgets/base_app_bar.dart'; // Adjust this import based on your project structure

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(23.033863, 72.585022);
  ValueNotifier<double> _currentSliderValue = ValueNotifier(3);
  ValueNotifier<bool> entrySwitch = ValueNotifier(true);
  ValueNotifier<bool> exitSwitch = ValueNotifier(false);
  TextEditingController nameController = TextEditingController();

  // final _geofenceService = GeofenceService.instance.setup(
  //     interval: 5000,
  //     accuracy: 100,
  //     loiteringDelayMs: 60000,
  //     statusChangeDelayMs: 10000,
  //     useActivityRecognition: true,
  //     allowMockLocations: false,
  //     printDevLog: false,
  //     geofenceRadiusSortType: GeofenceRadiusSortType.DESC);

  //Position? _currentPosition;
  // double _currentLat = 23.033863;
  // double _currentLong = 72.585022;

  double _currentLat = 0;
  double _currentLong = 0;

  @override
  void initState() {
    super.initState();
    getCurrentLocation(context);
    //_requestLocationPermission();
    // // _geofenceService
    //     .start(_geofenceList)
    //     .catchError(_onError); // Request location permission on initialization
  }
  //
  // void _onError(error) {
  //   final errorCode = getErrorCodesFromError(error);
  //   if (errorCode == null) {
  //     print('Undefined error: $error');
  //     return;
  //   }
  //
  //   print('ErrorCode: $errorCode');
  // }
  // Request location permission
  // void _requestLocationPermission() async {
  //   PermissionStatus status = await Permission.location.status;
  //   if (status == PermissionStatus.granted) {
  //     _getCurrentLocation();
  //   } else {
  //     _requestPermission();
  //   }
  // }

  // Future<void> _requestPermission() async {
  //   PermissionStatus status = await Permission.location.request();
  //   if (status == PermissionStatus.granted) {
  //     _getCurrentLocation();
  //   } else {
  //     _requestPermission();
  //   }
  // }

  // GeofenceService getObjectGEO() {
  //   final _geofenceService = GeofenceService.instance.setup(
  //       interval: 5000,
  //       accuracy: 100,
  //       loiteringDelayMs: 60000,
  //       statusChangeDelayMs: 10000,
  //       useActivityRecognition: true,
  //       allowMockLocations: false,
  //       printDevLog: false,
  //       geofenceRadiusSortType: GeofenceRadiusSortType.DESC);
  //   return _geofenceService;
  // }

  // Create a [Geofence] list.
  // final _geofenceList = <Geofence>[
  //   Geofence(
  //     id: 'place_1',
  //     latitude: 23.033863,
  //     longitude: 72.585022,
  //     radius: [
  //       GeofenceRadius(id: 'radius_100m', length: 100),
  //       GeofenceRadius(id: 'radius_25m', length: 25),
  //       GeofenceRadius(id: 'radius_250m', length: 250),
  //       GeofenceRadius(id: 'radius_200m', length: 200),
  //     ],
  //   ),
  // ];

  Future<LatLng> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    } else {
      debugPrint("Get current location manager");
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLat = position.latitude;
      _currentLong = position.longitude;

      debugPrint("Location lat long  $_currentLat  $_currentLong");

      setState(() {});

      GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentLat, _currentLong),
            zoom: 15.0,
          ),
        ),
      );

      return LatLng(_currentLat, _currentLong);
    }
  }

  // Set<Circle> circles = Set.from([
  //   Circle(
  //     circleId: CircleId('geo_fence_1'),
  //     center: LatLng(
  //       _currentLat!,
  //       _currentLong!,
  //     ),
  //     radius: 200,
  //     strokeWidth: 2,
  //     strokeColor: Colors.green,
  //     fillColor: Colors.green.withOpacity(0.15),
  //   ),
  // ]);

  // void _getCurrentLocation() async {
  //   try {
  //     final position = await Geolocator.getCurrentPosition(
  //         /*desiredAccuracy: LocationAccuracy.high*/);
  //     _currentPosition = position;
  //     //_currentlatlng.latitude=position.latitude
  //     _currentLat = position.latitude;
  //     _currentLong = position.longitude;
  //     print("LOCATION ${position.latitude} || ${position.longitude}");
  //
  //     _moveCameraToCurrentLocation();
  //   } catch (e) {
  //     print('Error getting location: $e');
  //   }
  // }

  // void _moveCameraToCurrentLocation() {
  //   if (_controller.isCompleted) {
  //     _controller.future.then((controller) {
  //       controller.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(
  //               _currentPosition!.latitude!, _currentPosition!.longitude!),
  //           zoom: 15,
  //         ),
  //       ));
  //     });
  //   }
  // }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId('current_location'),
        position: LatLng(_currentLat, _currentLong),
        infoWindow: InfoWindow(title: 'Your Location'),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: BaseAppBar(
        showTitle: true,
        title: S.of(context).addGeofencing,
        leadingIcon: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450.h,
              width: 1.sw,
              child: GoogleMap(
                  circles: {
                    Circle(
                      circleId: CircleId('geo_fence_1'),
                      center: LatLng(
                        _currentLat,
                        _currentLong,
                      ),
                      radius: 200,
                      strokeWidth: 2,
                      strokeColor: Colors.green,
                      fillColor: Colors.green.withOpacity(0.15),
                    ),
                  },
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentLat, _currentLong),
                    zoom: 8.0,
                  ),
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  markers: _createMarkers()
                  //markers: _currentPosition != null ? () : Set(),
                  ),
            ),
            _showRangeView()
          ],
        ),
      ),
    );
  }

  Widget _showRangeView() {
    return Container(
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))
                .r),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                S.of(context).selectARange,
                style: text_4B4F52_16_600,
              ),
              ValueListenableBuilder(
                valueListenable: _currentSliderValue,
                builder: (BuildContext context, double value, Widget? child) {
                  return SfSlider(
                    //label: "${_currentSliderValue.value} km",
                    activeColor: AppColor.favColor,
                    min: 1,
                    max: 10,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    value: _currentSliderValue.value,
                    labelFormatterCallback: (actualValue, formattedText) {
                      return "${actualValue} km";
                    },
                    tooltipTextFormatterCallback: (actualValue, formattedText) {
                      return "${_currentSliderValue.value.toInt()} km";
                    },
                    onChanged: (value) {
                      _currentSliderValue.value = value;
                    },
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                S.of(context).moveingOnExit,
                style: text_4B4F52_16_600,
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(S.of(context).onExit),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 40.w,
                    child: FittedBox(
                      child: ValueListenableBuilder(
                        valueListenable: exitSwitch,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return Switch.adaptive(
                            activeColor: AppColor.favColor,
                            value: exitSwitch.value,
                            onChanged: (value) {
                              if (value) {
                                entrySwitch.value = false;
                                exitSwitch.value = false;
                                exitSwitch.value = value;
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(S.of(context).onEntry),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 40.w,
                    child: FittedBox(
                      child: ValueListenableBuilder(
                        valueListenable: entrySwitch,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return Switch.adaptive(
                            activeColor: AppColor.favColor,
                            value: entrySwitch.value,
                            onChanged: (value) {
                              if (value) {
                                entrySwitch.value = false;
                                exitSwitch.value = false;
                                entrySwitch.value = value;
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              AppButton(
                S.of(context).continue1,
                () {
                  showNameBottomSheet();
                },
              )
            ],
          ),
        ));
  }

  Future showNameBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        //the rounded corner is created here
        borderRadius: BorderRadius.circular(20).r,
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18).r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).whatsTheNameOfGeofencing),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(S.of(context).name),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.santasGray.withOpacity(0.5),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10).r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.santasGray.withOpacity(0.5),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10).r)),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppButton(
                      S.of(context).save,
                      () {
                        var nameS = nameController.text.toString();
                        List<GeofencingLocation> list = appDB.locationList;
                        list.add(GeofencingLocation(
                            name: nameS,
                            isEntry: entrySwitch.value,
                            isExit: exitSwitch.value,
                            distance: _currentSliderValue.value.toInt(),
                            latitude: _currentLat!,
                            longitude: _currentLong!));
                        appDB.locationList = list;

                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
