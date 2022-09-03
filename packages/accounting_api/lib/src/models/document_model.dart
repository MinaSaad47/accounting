import 'package:accounting_api/src/common/datetime_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

@freezed
class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    int? id,
    required String name,
    required String path,
    @DatetimeJsonConverter() required DateTime time,
  }) = _DocumentModel;
  
  
  factory DocumentModel.fromJson(Map<String, Object?> json) =>
      _$DocumentModelFromJson(json);
}
