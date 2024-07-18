import 'package:dummy_api_call_retrofit/screens/model/geofencing_location.dart';
import 'package:hive/hive.dart';

import '../../locator/locator.dart';
import '../../values/constants.dart';

class AppDB {
  static const _appDbBox = '_appDbBox';
  static const fcmKey = 'fcm_key';
  static const platform = 'platform';
  var appCurrencyStatic = '\$';
  final Box<dynamic> _box;

  AppDB._(this._box);

  static Future<AppDB> getInstance() async {
    final box = await Hive.openBox<dynamic>(_appDbBox);
    return AppDB._(box);
  }

  T getValue<T>(key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> setValue<T>(key, T value) => _box.put(key, value);

  String get appLanguage => getValue("language", defaultValue: ENGLISH);
  set appLanguage(String update) => setValue("language", update);

  double get lastLat => getValue("lastLat", defaultValue: 23.025101242098515);
  set lastLat(double update) => setValue("lastLat", update);

  //23.025101242098515
  double get lastLong => getValue("lastLong", defaultValue: 72.5748821981208);
  set lastLong(double update) => setValue("lastLong", update);

  List<GeofencingLocation> get locationList => getLocation("location_list");

  set locationList(List<GeofencingLocation> locationList) =>
      setValue("location_list", locationList);

  logout() {}

  List<GeofencingLocation> getLocation(key) {
    final storedLocation = _box.get(key);
    if (storedLocation != null) {
      final locationList = List<GeofencingLocation>.from(storedLocation);
      return locationList;
    } else {
      return [];
    }
  }
}

final appDB = locator<AppDB>();

enum UserRole { B, I }
