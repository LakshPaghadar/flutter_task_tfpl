import 'dart:async';

import 'package:dummy_api_call_retrofit/generated/assets.dart';
import 'package:dummy_api_call_retrofit/screens/add_location_page.dart';
import 'package:dummy_api_call_retrofit/screens/widgets/base_app_bar.dart';
import 'package:dummy_api_call_retrofit/values/colors.dart';
import 'package:dummy_api_call_retrofit/values/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';

import '../generated/l10n.dart';
import 'app_lang/app_db.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({super.key});

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: BaseAppBar(
        showTitle: true,
        title: S.of(context).geofencing,
        leadingIcon: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          showAddButton(),
          SizedBox(
            height: 20.h,
          ),
          listView()
        ],
      ),
    );
  }

  Widget showAddButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddLocationPage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.all(Radius.circular(15).r)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).r,
            child: Row(
              children: [
                Image.asset(
                  Assets.images3,
                  height: 30.h,
                  width: 30.h,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(child: Text(S.of(context).addGeofencing)),
                SizedBox(
                  width: 15.w,
                ),
                Image.asset(
                  Assets.imagesPlus3,
                  height: 15.h,
                  width: 15.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listView() {
    //print("LOCATION_LIST ${appDB.locationList}");
    Completer<GoogleMapController> _controller = Completer();
    LatLng _center = const LatLng(23.033863, 72.585022);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('_appDbBox').listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              //shrinkWrap: true,
              itemCount: appDB.locationList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius:
                              BorderRadius.all(const Radius.circular(20).r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(20).r)),
                            child: GoogleMap(
                              onMapCreated: (controller) {
                                _controller.complete(controller);
                              },
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 8.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10).r,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appDB.locationList[index].name),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      Assets.imagesLocation3,
                                      height: 15.h,
                                      width: 15.w,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "${appDB.locationList[index].distance} km distance |",
                                      style: textBlack12_400,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.color898A8B,
                                      borderRadius: BorderRadius.all(Radius.circular(10).r),),
                                      child:
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2).r,
                                            child: appDB.locationList[index].isEntry ==
                                                    true
                                                ? Text(
                                                    S.of(context).onEntry,
                                                    style: textBlack12_400,
                                                  )
                                                : Text(
                                                    S.of(context).onExit,
                                                    style: textBlack12_400,
                                                  ),
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
