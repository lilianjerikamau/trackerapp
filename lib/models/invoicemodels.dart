import 'package:json_annotation/json_annotation.dart';

part 'invoicemodels.g.dart';

@JsonSerializable()
class Invoice {
  Invoice({
    this.id,
    this.trackerid,
    this.vegreg,
    this.client,
    this.mobile,
    this.vegamount,
    this.invoiceamt,
    this.paidamt,
    this.balance,
  });

  int? id;
  int? trackerid;
  String? vegreg;
  String? client;
  String? mobile;
  int? vegamount;
  int? invoiceamt;
  int? paidamt;
  int? balance;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        trackerid: json["trackerid"],
        vegreg: json['vegreg'],
        client: json["client"],
        mobile: json["mobile"],
        vegamount: json['vegamount'],
        invoiceamt: json["invoiceamt"],
        paidamt: json["paidamt"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trackerid": trackerid,
        "vegreg": vegreg,
        "client": client,
        "mobile": mobile,
        'vegamount': vegamount,
        "invoiceamt": invoiceamt,
        "paidamt": paidamt,
        "balance": balance,
      };
}
