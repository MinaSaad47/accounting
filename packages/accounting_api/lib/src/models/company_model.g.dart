// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CompanyModel _$$_CompanyModelFromJson(Map<String, dynamic> json) =>
    _$_CompanyModel(
      id: json['id'] as String?,
      owner: json['owner'] as String,
      commercialFeature: json['commercialFeature'] as String,
      isWorking: json['isWorking'] as bool,
      legalEntity: json['legalEntity'] as String?,
      fileNumber: json['fileNumber'] as String?,
      registerNumber: json['registerNumber'] as String?,
      startDate: _$JsonConverterFromJson<String, DateTime>(
          json['startDate'], const DatetimeJsonConverter().fromJson),
      stopDate: _$JsonConverterFromJson<String, DateTime>(
          json['stopDate'], const DatetimeJsonConverter().fromJson),
      generalTaxMission: json['generalTaxMission'] as String?,
      valueTaxMission: json['valueTaxMission'] as String?,
      activityNature: json['activityNature'] as String?,
      activityLocation: json['activityLocation'] as String?,
      recordNumber: json['recordNumber'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_CompanyModelToJson(_$_CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'commercialFeature': instance.commercialFeature,
      'isWorking': instance.isWorking,
      'legalEntity': instance.legalEntity,
      'fileNumber': instance.fileNumber,
      'registerNumber': instance.registerNumber,
      'startDate': _$JsonConverterToJson<String, DateTime>(
          instance.startDate, const DatetimeJsonConverter().toJson),
      'stopDate': _$JsonConverterToJson<String, DateTime>(
          instance.stopDate, const DatetimeJsonConverter().toJson),
      'generalTaxMission': instance.generalTaxMission,
      'valueTaxMission': instance.valueTaxMission,
      'activityNature': instance.activityNature,
      'activityLocation': instance.activityLocation,
      'recordNumber': instance.recordNumber,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
