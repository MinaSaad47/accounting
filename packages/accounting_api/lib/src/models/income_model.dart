import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:accounting_api/src/common/datetime_json_converter.dart';

part 'income_model.freezed.dart';
part 'income_model.g.dart';

@freezed
class IncomeModel with _$IncomeModel {
  const factory IncomeModel({
    String? id,
    required num value,
    required String description,
    @DatetimeJsonConverter() DateTime? time,
    @JsonKey(name: 'admin') String? adminName,
    @JsonKey(name: 'company') String? companyName,
  }) = _IncomeModel;

  factory IncomeModel.fromJson(Map<String, Object?> json) =>
      _$IncomeModelFromJson(json);
}
