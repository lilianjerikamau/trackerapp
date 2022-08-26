// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoicemodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      id: json['id'] as int?,
      trackerid: json['trackerid'] as int?,
      vegreg: json['vegreg'] as String?,
      client: json['client'] as String?,
      mobile: json['mobile'] as String?,
      vegamount: json['vegamount'] as int?,
      invoiceamt: json['invoiceamt'] as int?,
      paidamt: json['paidamt'] as int?,
      balance: json['balance'] as int?,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'trackerid': instance.trackerid,
      'vegreg': instance.vegreg,
      'client': instance.client,
      'mobile': instance.mobile,
      'vegamount': instance.vegamount,
      'invoiceamt': instance.invoiceamt,
      'paidamt': instance.paidamt,
      'balance': instance.balance,
    };
