import 'dart:io';

import 'package:dummy_api_call_retrofit/notwork/store/post_store.dart';
import 'package:dummy_api_call_retrofit/screens/app_lang/app_db.dart';
import 'package:dummy_api_call_retrofit/screens/location_list_page.dart';
import 'package:dummy_api_call_retrofit/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

import '../generated/l10n.dart';
import '../values/colors.dart';
import '../values/style.dart';
import 'image_card.dart';

class PhotosListPage extends StatefulWidget {
  const PhotosListPage({super.key});

  @override
  State<PhotosListPage> createState() => _PhotosListPageState();
}

class _PhotosListPageState extends State<PhotosListPage> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> paginationLoading = ValueNotifier(false);
  List<ReactionDisposer>? disposer;
  final ScrollController _scrollController = ScrollController();
  final _searchController = TextEditingController();
  int _page = 1;
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
    Geolocator.isLocationServiceEnabled();
    registerReactions();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      paginationLoading.value = true;
      await postStore.getPhotosList(_page, _perPage);
      paginationLoading.value = false;
    });
    _searchController.addListener(() {
      postStore.photosList;
    });
  }

  Future getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(S.of(context).locationServicesAreDisabled);
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      appDB.lastLat = position.latitude;
      appDB.lastLong = position.longitude;
    }
  }

  checkLocationPermission() async {
    if (Platform.isAndroid) {
      if (!await Permission.location.request().isPermanentlyDenied) {
        //Allow
        detectLocation();
      } else if (await Permission.location.request().isPermanentlyDenied) {
        if (!mounted) return;
        //go to settings
        showLocationSettingDialog();
      }
    } else {
      var status = await Permission.location.request();
      if (status.isGranted) {
        //Allow
        detectLocation();
      } else if (status.isDenied) {
        //Allow
        detectLocation();
      } else if (status.isPermanentlyDenied) {
        if (!mounted) return;
        //open settings
        showLocationSettingDialog();
      }
    }
  }

  detectLocation() async {
    bool serviceEnabled;
    // LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      bool service = await Geolocator.isLocationServiceEnabled();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    appDB.lastLat = position.latitude;
    appDB.lastLong = position.longitude;
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
              S.of(context).locationPermission,
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
                    S.of(context).desc_text,
                    maxLines: 3,
                    style: textRegular.copyWith(
                        fontSize: 15.sp, color: Colors.black),
                  ),
                ),
                10.0.verticalSpace,
                Flexible(
                  child: Text(
                    S
                        .of(context)
                        .toEnableThisclickDeviceLocationSettingsBelowAndActivateThis,
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
                    openAppSettings();
                  },
                  child: Text(
                    "Device location Settings",
                    style: textMedium.copyWith(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void registerReactions() {
    disposer ??= [
      reaction((p0) => postStore.photosList, (list) {
        debugPrint("LIST_LIST : ${list.length}");
        if (list.isNotEmpty) {
          paginationLoading.value = false;
          setState(() {});
        }
      }),
      reaction((p0) => postStore.errorMessage, (errorMsg) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMsg.toString())));
      }),
      reaction((p0) => postStore.photosList, (list) {
        debugPrint("LIST_LIST : ${list.length}");
        if (list.isNotEmpty) {
          paginationLoading.value = false;
        }
      }),
    ];
  }

  void removeReactions() {
    if (disposer == null) {
      return;
    } else {
      for (var ele in disposer!) {
        ele.reaction.dispose();
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    paginationLoading.dispose();
    isLoading.dispose();
    removeReactions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 10.w,
        title: Text(S.of(context).home),
        backgroundColor: AppColor.bgColor,
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ListTile(
              leading: const Icon(Icons.message),
              title: Text(S.of(context).home),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LocationListPage()));
            },
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(S.of(context).geofencing),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsPage()));
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).settings),
            ),
          ),
        ],
      )),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).r,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(hintText: S.of(context).search),
              onChanged: (value) {
                debugPrint("TEXT_VALUE $value");
                postStore.filterPostsByName(value);
              },
            ),
          ),
          const SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return child!;
                }
              },
              child: buildPhotoListView(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPhotoListView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Observer(
        builder: (context) {
          if (isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (postStore.photosList.isEmpty) {
            return Text(S.of(context).noDataFound);
          } else {
            return ListView.builder(
              itemCount: postStore.photosList.length + 1,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index < postStore.photosList.length) {
                  return ImageCard(
                    imageUrl: postStore.photosList[index].url!,
                    description: postStore.photosList[index].title!,
                  );
                } else {
                  return _buildProgressIndicator();
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _loadData() async {
    if (!paginationLoading.value) {
      setState(() {
        paginationLoading.value = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      await postStore.getPhotosList(_page, _perPage);
      setState(() {
        paginationLoading.value = false;
        _page = _page + 10;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
