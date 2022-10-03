import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:accounting_api/src/common/datetime_json_converter.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    String? id,
    required num value,
    required String description,
    @DatetimeJsonConverter() DateTime? time,
    @JsonKey(name: 'user') String? userName,
    @JsonKey(name: 'company') String? companyName,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, Object?> json) =>
      _$ExpenseModelFromJson(json);
}
