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
        this.backupimeino,
        this.backupdeviceno2,
        this.deviceno,
        this.backupdeviceno,
        this.backupimeino2,
        this.imeino,
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

  String? backupimeino;
  String? backupdeviceno2;
  String? deviceno;
  String? backupdeviceno;
  String? backupimeino2;
  String? imeino;

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
      backupimeino: json['backupimeino'],
      backupdeviceno2: json['backupdeviceno2'],
      deviceno: json['deviceno'],
      backupdeviceno :json['backupdeviceno'],
      backupimeino2: json['backupimeino2'] ,
      imeino:json['imeino'] ,
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
        "remarks": remarks,
  "backupimeino": backupimeino,
  "backupdeviceno2": backupdeviceno2,
  "deviceno" :deviceno,
  "backupdeviceno": backupdeviceno,
  "backupimeino2" :backupimeino2,
  "imeino": imeino,
      };
}
