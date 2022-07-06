import 'package:json_annotation/json_annotation.dart';

part 'usermodels.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.fullname,
    this.email,
    this.username,
    this.password,
    this.resetpassword,
    this.companyName,
  });

  int? id;
  String? fullname;

  String? email;
  String? username;
  String? password;
  bool? resetpassword;

  String? companyName;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      fullname: json["fullname"],
      resetpassword: json['resetpassword'],
      email: json["email"],
      username: json["username"],
      companyName: json['companyname'],
      password: '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "username": username,
        'resetpassword': resetpassword,
        "companyname": companyName
      };
}

class CompanySettings {
  String? baseUrl;
  String? imageName;

  CompanySettings({this.baseUrl, this.imageName});
}
