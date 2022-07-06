// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      resetpassword: json['resetpassword'] as bool,
      companyName: json['companyName'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'resetpassword': instance.resetpassword,
      'companyName': instance.companyName,
    };
