import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_capital_model.freezed.dart';
part 'money_capital_model.g.dart';

@freezed
class MoneyCapitalModel with _$MoneyCapitalModel {
  const factory MoneyCapitalModel({
    String? id,
    required num value,
    required DateTime time,
  }) = _MoneyCapitalModel;

  factory MoneyCapitalModel.fromJson(Map<String, Object> json) =>
      _$MoneyCapitalModelFromJson(json);
}
