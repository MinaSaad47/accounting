import 'package:freezed_annotation/freezed_annotation.dart';

part 'funder_model.freezed.dart';
part 'funder_model.g.dart';

@freezed
class FunderModel with _$FunderModel {
  const factory FunderModel({
    int? id,
    required String name,
    @JsonKey(name: 'company_id') required int companyId,
  }) = _FunderModel;

  factory FunderModel.fromJson(Map<String, Object?> json) =>
      _$FunderModelFromJson(json);
}
