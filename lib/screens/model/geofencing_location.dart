import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geofencing_location.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class GeofencingLocation extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "name")
  final String name;

  @HiveField(1)
  @JsonKey(name: "isEntry")
  final bool isEntry;

  @HiveField(2)
  @JsonKey(name: "isExit")
  final bool isExit;

  @HiveField(3)
  @JsonKey(name: "latitude")
  final double latitude;

  @HiveField(4)
  @JsonKey(name: "longitude")
  final double longitude;

  @HiveField(5)
  @JsonKey(name: "distance")
  final int distance;

  GeofencingLocation({
    required this.name,
    required this.isEntry,
    required this.isExit,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });

  GeofencingLocation copyWith({
    String? name,
    bool? isEntry,
    bool? isExit,
    double? latitude,
    double? longitude,
    int? distance,
  }) =>
      GeofencingLocation(
        name: name ?? this.name,
        isEntry: isEntry ?? this.isEntry,
        isExit: isExit ?? this.isExit,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        distance: distance ?? this.distance,
      );

  factory GeofencingLocation.fromJson(Map<String, dynamic> json) =>
      _$GeofencingLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeofencingLocationToJson(this);
}
