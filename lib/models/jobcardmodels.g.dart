// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobcardmodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobCard _$JobCardFromJson(Map<String, dynamic> json) => JobCard(
      id: json['id'] as int?,
      customername: json['customername'] as String?,
      finphone: json['finphone'] as String?,
      custphone: json['custphone'] as String?,
      vehreg: json['vehreg'] as String?,
      location: json['location'] as String?,
      docno: json['docno'] as String?,
      vehmodel: json['vehmodel'] as String?,
      notracker: json['notracker'] as int?,
      remarks: json['remarks'] as String?,
      date: json['date'] as String?,
      finname: json['finname'] as String?,
    );

Map<String, dynamic> _$JobCardToJson(JobCard instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'customername': instance.customername,
      'finphone': instance.finphone,
      'custphone': instance.custphone,
      'vehreg': instance.vehreg,
      'location': instance.location,
      'docno': instance.docno,
      'vehmodel': instance.vehmodel,
      'notracker': instance.notracker,
      'remarks': instance.remarks,
      'finname': instance.finname,
    };
