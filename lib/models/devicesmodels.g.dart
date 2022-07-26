// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devicesmodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as int?,
      serialno: json['serialno'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'serialno': instance.serialno,
      'description': instance.description,
    };
