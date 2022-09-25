import 'dart:core';

import 'package:accounting_api/src/common/datetime_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    int? id,
    required String owner,
    required String commercialFeature,
    required bool isWorking,
    String? legalEntity,
    String? fileNumber,
    String? registerNumber,
    @DatetimeJsonConverter() DateTime? startDate,
    @DatetimeJsonConverter() DateTime? stopDate,
    String? generalTaxMission,
    String? valueTaxMission,
    String? activityNature,
    String? activityLocation,
    String? recordNumber,
    String? username,
    String? password,
    String? email,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, Object?> json) =>
      _$CompanyModelFromJson(json);
}
