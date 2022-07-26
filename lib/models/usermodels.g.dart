// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      resetpassword: json['resetpassword'] as bool?,
      companyname: json['companyname'] as String?,
      hrid: json['hrid'] as int?,
      costcenter: json['costcenter'] as int?,
      custid: json['custid'] as int?,
      branchname: json['branchname'] as String?,
      technician: json['technician'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'costcenter': instance.costcenter,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'resetpassword': instance.resetpassword,
      'hrid': instance.hrid,
      'custid': instance.custid,
      'companyname': instance.companyname,
      'branchname': instance.branchname,
      'technician': instance.technician,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      custid: json['custid'] as int?,
      company: json['company'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'custid': instance.custid,
      'company': instance.company,
    };
