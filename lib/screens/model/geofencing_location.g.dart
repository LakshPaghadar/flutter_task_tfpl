// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofencing_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeofencingLocationAdapter extends TypeAdapter<GeofencingLocation> {
  @override
  final int typeId = 0;

  @override
  GeofencingLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeofencingLocation(
      name: fields[0] as String,
      isEntry: fields[1] as bool,
      isExit: fields[2] as bool,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      distance: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GeofencingLocation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isEntry)
      ..writeByte(2)
      ..write(obj.isExit)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeofencingLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeofencingLocation _$GeofencingLocationFromJson(Map<String, dynamic> json) =>
    GeofencingLocation(
      name: json['name'] as String,
      isEntry: json['isEntry'] as bool,
      isExit: json['isExit'] as bool,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distance: (json['distance'] as num).toInt(),
    );

Map<String, dynamic> _$GeofencingLocationToJson(GeofencingLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isEntry': instance.isEntry,
      'isExit': instance.isExit,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance': instance.distance,
    };
