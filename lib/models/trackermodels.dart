import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trackermodels.g.dart';

@JsonSerializable()
class Tracker {
  Tracker({
    this.trackerid,
    this.trackerdocno,
    this.financier,
    this.custmobile,
    this.vehreg,
    this.imei,
    this.model,
    this.trackertype,
    this.trackerlocation,
    this.device,
    this.customer,
  });

  int? trackerid;
  String? trackerdocno;
  int? financier;
  String? custmobile;
  String? vehreg;
  String? imei;
  bool? model;
  int? trackertype;
  int? trackerlocation;
  String? device;
  String? customer;

  factory Tracker.fromJson(Map<String, dynamic> json) => Tracker(
        trackerid: json["trackerid"],
        trackerdocno: json["trackerdocno"],
        financier: json['financier'],
        custmobile: json["custmobile"],
        vehreg: json["vehreg"],
        imei: json['imei'],
        model: json["model"],
        trackertype: json["trackertype"],
        trackerlocation: json["trackerlocation"],
        device: json["device"],
        customer: json["customer"],
      );

  Map<String, dynamic> toJson() => {
        "trackerid": trackerid,
        "trackerdocno": trackerdocno,
        "financier": financier,
        "custmobile": custmobile,
        "vehreg": vehreg,
        'imei': imei,
        "model": model,
        "trackertype": trackertype,
        "trackerlocation": trackerlocation,
        "device": device,
        "customer": customer,
      };
}

class ImageList {
  ImageList(this.images);

  List<Images> images;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'photolist': images,
      };
}

class Images {
  Images({required this.filename, required this.attachment});

  String filename;
  String attachment;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'attachment': attachment,
        'filename': filename,
      };
}
