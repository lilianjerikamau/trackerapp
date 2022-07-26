import 'package:json_annotation/json_annotation.dart';

part 'financiermodels.g.dart';

@JsonSerializable()
class Financier {
  Financier({this.id, this.name, this.email, this.mobile});

  int? id;
  String? name;

  String? email;
  String? mobile;

  factory Financier.fromJson(Map<String, dynamic> json) => Financier(
        id: json["custid"],
        email: json["email"],
        mobile: json["mobile"],
        name: json["company"],
      );
  Map<String, dynamic> toJson() => {
        "custid": id,
        "company": name,
        "email": email,
        "mobile": mobile,
      };
}
