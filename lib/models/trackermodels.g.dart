// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trackermodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracker _$TrackerFromJson(Map<String, dynamic> json) => Tracker(
      trackerid: json['trackerid'] as int?,
      trackerdocno: json['trackerdocno'] as String?,
      financier: json['financier'] as int?,
      custmobile: json['custmobile'] as String?,
      vehreg: json['vehreg'] as String?,
      imei: json['imei'] as String?,
      model: json['model'] as bool?,
      trackertype: json['trackertype'] as int?,
      trackerlocation: json['trackerlocation'] as int?,
      device: json['device'] as String?,
      customer: json['customer'] as String?,
    );

Map<String, dynamic> _$TrackerToJson(Tracker instance) => <String, dynamic>{
      'trackerid': instance.trackerid,
      'trackerdocno': instance.trackerdocno,
      'financier': instance.financier,
      'custmobile': instance.custmobile,
      'vehreg': instance.vehreg,
      'imei': instance.imei,
      'model': instance.model,
      'trackertype': instance.trackertype,
      'trackerlocation': instance.trackerlocation,
      'device': instance.device,
      'customer': instance.customer,
    };
