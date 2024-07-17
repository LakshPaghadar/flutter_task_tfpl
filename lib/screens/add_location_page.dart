import 'dart:async';
import 'package:dummy_api_call_retrofit/screens/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  ValueNotifier<bool> entrySwitch = ValueNotifier(false);
  ValueNotifier<bool> exitSwitch = ValueNotifier(false);
  TextEditingController nameController=TextEditingController();

  //LocationData? _currentLocation; // To store the current location data
  //Location location = Location(); // Location service instance

  @override
  void initState() {
    super.initState();
    // _requestLocationPermission(); // Request location permission on initialization
  }

  // Request location permission
  // void _requestLocationPermission() async {
  //   var status = await location.requestPermission();
  //   if (status == PermissionStatus.granted) {
  //     _getCurrentLocation(); // Get current location if permission granted
  //   }
  // }

  // Get the current location
  // void _getCurrentLocation() async {
  //   try {
  //     var locationData = await location.getLocation();
  //     setState(() {
  //       _currentLocation = locationData;
  //       debugPrint("LOCATION + ${locationData.latitude} ");
  //     });
  //     _moveCameraToCurrentLocation(); // Move camera to current location
  //   } catch (e) {
  //     print('Error getting location: $e');
  //   }
  // }

  // Move camera to the current location
  // void _moveCameraToCurrentLocation() {
  //   if (_controller.isCompleted) {
  //     _controller.future.then((controller) {
  //       controller.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
  //           zoom: 15,
  //         ),
  //       ));
  //     });
  //   }
  // }

  // Create markers for the current location
  // Set<Marker> _createMarkers() {
  //   return [
  //     Marker(
  //       markerId: MarkerId('current_location'),
  //       position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
  //       infoWindow: InfoWindow(title: 'Your Location'),
  //     ),
  //   ].toSet();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 8.0,
                ),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                //markers: _currentLocation != null ? _createMarkers() : Set(),
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
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)).r
      ),
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
                    builder: (BuildContext context, bool value, Widget? child) {
                      return Switch.adaptive(
                        activeColor: AppColor.favColor,
                        value: exitSwitch.value,
                        onChanged: (value) {
                          exitSwitch.value = value;
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
                    builder: (BuildContext context, bool value, Widget? child) {
                      return Switch.adaptive(
                        activeColor: AppColor.favColor,
                        value: entrySwitch.value,
                        onChanged: (value) {
                          entrySwitch.value = value;
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
      shape: RoundedRectangleBorder(		//the rounded corner is created here
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
                    SizedBox(height: 20.h,),
                    Text(S.of(context).name),
                    SizedBox(height: 2.h,),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.santasGray.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10).r)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.santasGray.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10).r)
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    AppButton("Save", () {

                    },)
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
