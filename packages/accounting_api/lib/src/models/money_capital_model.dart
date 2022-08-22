import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_capital_model.freezed.dart';
part 'money_capital_model.g.dart';

@freezed
class MoneyCapitalModel with _$MoneyCapitalModel {
  const factory MoneyCapitalModel({
    int? id,
    required num value,
    required DateTime time,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'company_name') String? companyName,
  }) = _MoneyCapitalModel;

  factory MoneyCapitalModel.fromJson(Map<String, Object> json) =>
      _$MoneyCapitalModelFromJson(json);
}
