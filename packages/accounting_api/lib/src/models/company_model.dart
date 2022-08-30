import 'dart:core';

import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_api/src/common/datetime_json_converter.dart';
import 'package:accounting_api/src/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "funders") required List<FunderModel> funders,
    @JsonKey(name: "commercial_feature") required String commercialFeature,
    @JsonKey(name: "is_working") required bool isWorking,
    @JsonKey(name: "legal_entity") required String legalEntity,
    @JsonKey(name: "file_number") String? fileNumber,
    @JsonKey(name: "register_number") required String registerNumber,
    @DatetimeJsonConverter()
    @JsonKey(name: "start_date")
        required DateTime startDate,
    @DatetimeJsonConverter() @JsonKey(name: "stop_date") DateTime? stopDate,
    @JsonKey(name: "general_tax_mission") required String generalTaxMission,
    @JsonKey(name: "value_tax_mission") String? valueTaxMission,
    @JsonKey(name: "activity_nature") required String activityNature,
    @JsonKey(name: "activity_location") required String activityLocation,
    @JsonKey(name: "accounts") required String accounts,
    @DatetimeJsonConverter()
    @JsonKey(name: "joining_date")
        DateTime? joiningDate,
    @JsonKey(name: "natural_id") String? naturalId,
    @JsonKey(name: "money_capitals") List<ExpenseModel>? moneyCapitals,
    @JsonKey(name: "record_side") String? recordSide,
    @JsonKey(name: "record_number") required String recordNumber,
    @JsonKey(name: "user_name") required String userName,
    @JsonKey(name: "passport") String? passport,
    @JsonKey(name: "verification_code") String? verificationCode,
    @JsonKey(name: "email") required String email,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, Object?> json) =>
      _$CompanyModelFromJson(json);
}
