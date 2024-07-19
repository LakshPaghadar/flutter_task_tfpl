import 'dart:async';
import 'dart:io';

import 'package:dummy_api_call_retrofit/screens/app_lang/app_db.dart';
import 'package:dummy_api_call_retrofit/screens/model/geofencing_location.dart';
import 'package:dummy_api_call_retrofit/screens/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? mapController;
  final ValueNotifier<double> _currentSliderValue = ValueNotifier(1);
  final ValueNotifier<int> _radiusNotifier = ValueNotifier(1);
  ValueNotifier<bool> entrySwitch = ValueNotifier(true);
  ValueNotifier<bool> exitSwitch = ValueNotifier(false);
  TextEditingController nameController = TextEditingController();

  double _currentLat = appDB.lastLat;
  double _currentLong = appDB.lastLong;

  @override
  void initState() {
    super.initState();
    debugPrint("DEFAULT LOCATION ${_currentLat} | ${_currentLong}");
    getCurrentLocation(context);
  }

  @override
  void dispose() {
    _currentSliderValue.dispose();
    _radiusNotifier.dispose();
    entrySwitch.dispose();
    exitSwitch.dispose();

    super.dispose();
  }

  checkLocationPermission() async {
    if (Platform.isAndroid) {
      debugPrint('isAndroid');
      if (!await Permission.location.request().isPermanentlyDenied) {
        if (await Permission.location.isDenied) {
          checkLocationPermission();
        } else {
          getCurrentLocation(context);
        }
      } else if (await Permission.location.request().isPermanentlyDenied) {
        showLocationSettingDialog();
      }
      //21.52401909240622, 70.45554851358295
    } else {
      var status = await Permission.location.request();
      if (status.isPermanentlyDenied) {
        if (!mounted) return;
        showLocationSettingDialog();
      } else {
        getCurrentLocation(context);
      }
    }
  }

  showLocationSettingDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
              title: Text(
                "Location Permission",
                textAlign: TextAlign.center,
                style: textBold.copyWith(fontSize: 18.sp, color: Colors.black),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "Please grant location permission in Device location Settings for additional functionality.",
                      maxLines: 3,
                      style: textRegular.copyWith(
                          fontSize: 15.sp, color: Colors.black),
                    ),
                  ),
                  10.0.verticalSpace,
                  Flexible(
                    child: Text(
                      'To enable this,click Device location Settings below and activate this feature under the Permissions menu',
                      maxLines: 3,
                      style: textRegular.copyWith(
                          fontSize: 15.sp, color: Colors.black),
                    ),
                  )
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor, elevation: 0),
                      onPressed: () {
                        Navigator.pop(context);
                        //shouldRequestPermission = true;
                        openAppSettings();
                      },
                      child: Text(
                        "Device location Settings",
                        style: textMedium.copyWith(
                            fontSize: 16.sp, color: Colors.white),
                      )),
                )
              ]),
        );
      },
    );
  }

  Future<LatLng> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(S.of(context).locationServicesAreDisabled);
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentLat = position.latitude;
      _currentLong = position.longitude;

      setState(() {});

      mapController = await _controller.future;
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentLat, _currentLong),
            zoom: getZoomValue(_radiusNotifier.value),
          ),
        ),
      );

      return LatLng(_currentLat, _currentLong);
    }
  }

  void zoomOut() {
    setState(() {
      mapController?.animateCamera(
          CameraUpdate.zoomTo(getZoomValue(_radiusNotifier.value)));
    });
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(_currentLat, _currentLong),
        infoWindow: InfoWindow(title: S.of(context).yourLocation),
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
            ValueListenableBuilder(
              valueListenable: _radiusNotifier,
              builder: (context, value, child) {
                return SizedBox(
                  height: 450.h,
                  width: 1.sw,
                  child: GoogleMap(
                    circles: {
                      Circle(
                        circleId: const CircleId('geo_fence_1'),
                        center: LatLng(
                          _currentLat,
                          _currentLong,
                        ),
                        //23.075375435548818, 72.52567223150744
                        radius: value * 500,
                        strokeWidth: 2,
                        strokeColor: Colors.green,
                        fillColor: Colors.green.withOpacity(0.15),
                      ),
                    },
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                      mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentLat, _currentLong),
                      zoom: getZoomValue(_radiusNotifier.value),
                    ),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: _createMarkers(),
                  ),
                );
              },
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
                    activeColor: AppColor.favColor,
                    min: 1,
                    max: 10,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    value: _currentSliderValue.value,
                    labelFormatterCallback: (actualValue, formattedText) {
                      return "$actualValue km";
                    },
                    tooltipTextFormatterCallback: (actualValue, formattedText) {
                      return "${_currentSliderValue.value.toInt()} km";
                    },
                    onChanged: (value) {
                      _currentSliderValue.value = value;
                      debugPrint(
                          "RADIUS_CHANGE + value : $value | rn : ${_radiusNotifier.value}");

                      debugPrint(
                          "RADIUS_CHANGE + Int : ${value.toInt()} | rn : ${_currentSliderValue.value.toInt()}");

                      if (value.toInt() == _radiusNotifier.value) {
                      } else {
                        _radiusNotifier.value = value.toInt();
                        zoomOut();
                      }
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

  double getZoomValue(int radius) {
    switch (radius) {
      case 1:
        return 14.0;
      case 2:
        return 13.0;
      case 3:
        return 13.0;
      case 4:
        return 12.0;
      case 5:
        return 12.0;
      case 6:
        return 12.0;
      case 7:
        return 12.0;
      case 8:
        return 11.0;
      case 9:
        return 11.0;
      case 10:
        return 11.0;
      default:
        return 11.0;
    }
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
                                BorderRadius.all(const Radius.circular(10).r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.santasGray.withOpacity(0.5),
                            ),
                            borderRadius:
                                BorderRadius.all(const Radius.circular(10).r)),
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
                        list.add(
                          GeofencingLocation(
                              name: nameS,
                              isEntry: entrySwitch.value,
                              isExit: exitSwitch.value,
                              distance: _currentSliderValue.value.toInt(),
                              latitude: _currentLat,
                              longitude: _currentLong,
                              radius: _radiusNotifier.value),
                        );
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
