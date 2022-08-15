import 'package:freezed_annotation/freezed_annotation.dart';

part 'funder_model.freezed.dart';
part 'funder_model.g.dart';

@freezed
class FunderModel with _$FunderModel {
  const factory FunderModel({
    String? id,
    required String name,
  }) = _FunderModel;

  factory FunderModel.fromJson(Map<String, Object> json) =>
      _$FunderModelFromJson(json);
}
