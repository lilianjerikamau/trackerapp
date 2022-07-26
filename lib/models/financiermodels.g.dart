// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financiermodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Financier _$FinancierFromJson(Map<String, dynamic> json) => Financier(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$FinancierToJson(Financier instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
    };
