import 'package:json_annotation/json_annotation.dart';

part 'jobcardmodels.g.dart';

@JsonSerializable()
class JobCard {
  JobCard(
      {this.id,
      this.customername,
      this.finphone,
      this.custphone,
      this.vehreg,
      this.location,
      this.docno,
      this.vehmodel,
      this.notracker,
      this.remarks,
      this.date,
      this.finname});

  int? id;
  String? date;
  String? customername;
  String? finphone;
  String? custphone;
  String? vehreg;
  String? location;
  String? docno;
  String? vehmodel;
  int? notracker;
  String? remarks;
  String? finname;

  factory JobCard.fromJson(Map<String, dynamic> json) => JobCard(
        id: json["id"],
        customername: json["Customer"],
        finphone: json['finphone'],
        custphone: json["Custphone"],
        vehreg: json["vehreg"],
        location: json['location'],
        docno: json["docno"],
        vehmodel: json["vehmodel"],
        notracker: json["notracker"],
        date: json["date"],
        remarks: json["remarks"],
        finname: json['finname'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Customer": customername,
        "finphone": finphone,
        "Custphone": custphone,
        "vehreg": vehreg,
        'location': location,
        "docno": docno,
        "vehmodel": vehmodel,
        "notracker": notracker,
        "date": date,
        "finname": finname,
        "remarks": remarks
      };
}
