import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:accounting_api/src/common/datetime_json_converter.dart';

part 'money_capital_model.freezed.dart';
part 'money_capital_model.g.dart';

@freezed
class MoneyCapitalModel with _$MoneyCapitalModel {
  const factory MoneyCapitalModel({
    int? id,
    required num value,
    @DatetimeJsonConverter() DateTime? time,
    @JsonKey(name: 'user') String? userName,
    @JsonKey(name: 'company') String? companyName,
  }) = _MoneyCapitalModel;

  factory MoneyCapitalModel.fromJson(Map<String, Object?> json) =>
      _$MoneyCapitalModelFromJson(json);
}
