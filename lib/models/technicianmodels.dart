import 'package:json_annotation/json_annotation.dart';

part 'technicianmodels.g.dart';

@JsonSerializable()
class Technician {
  Technician({this.id, this.name});

  int? id;
  String? name;

  factory Technician.fromJson(Map<String, dynamic> json) => Technician(
        id: json["empid"],
        name: json["empname"],
      );
  Map<String, dynamic> toJson() => {
        "empid": id,
        "empname": name,
      };
}
