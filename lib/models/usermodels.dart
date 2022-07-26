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
    this.companyname,
    this.hrid,
    this.costcenter,
    this.custid,
    this.branchname,
    this.technician,
  });

  int? id;
  String? fullname;
  int? costcenter;
  String? email;
  String? username;
  String? password;
  bool? resetpassword;
  int? hrid;
  int? custid;
  String? companyname;
  String? branchname;
  bool? technician;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      fullname: json["fullname"],
      resetpassword: json['resetpassword'],
      email: json["email"],
      username: json["username"],
      companyname: json['companyname'],
      costcenter: json["costcenter"],
      hrid: json["hrid"],
      branchname: json["branchname"],
      technician: json["technician"],
      custid: json["custid"],
      password: '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "costcenter": costcenter,
        "username": username,
        'resetpassword': resetpassword,
        "companyname": companyname,
        "hrid": hrid,
        "custid": custid,
        "branchname": branchname,
        "technician": technician,
      };
}

@JsonSerializable()
class Customer {
  int? custid;
  String? company;

  Customer({
    this.custid,
    this.company,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() {
    return 'Customer{custid: $custid}';
  }
}

class CompanySettings {
  String? baseUrl;
  String? imageName;

  CompanySettings({this.baseUrl, this.imageName});
}
