import 'package:json_annotation/json_annotation.dart';

part 'devicesmodels.g.dart';

@JsonSerializable()
class Device {
  Device({
    this.id,
    this.serialno,
    this.description,
  });

  int? id;
  String? serialno;

  String? description;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        description: json["description"],
        serialno: json['serialno'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "serialno": serialno,
      };
}
