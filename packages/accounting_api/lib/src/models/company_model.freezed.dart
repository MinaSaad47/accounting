// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'company_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  return _CompanyModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "funders")
  List<FunderModel> get funders => throw _privateConstructorUsedError;
  @JsonKey(name: "commercial_feature")
  String get commercialFeature => throw _privateConstructorUsedError;
  @JsonKey(name: "is_working")
  bool get isWorking => throw _privateConstructorUsedError;
  @JsonKey(name: "legal_entity")
  String get legalEntity => throw _privateConstructorUsedError;
  @JsonKey(name: "file_number")
  String? get fileNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "register_number")
  String get registerNumber => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  @JsonKey(name: "start_date")
  DateTime get startDate => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  @JsonKey(name: "stop_date")
  DateTime? get stopDate => throw _privateConstructorUsedError;
  @JsonKey(name: "general_tax_mission")
  String get generalTaxMission => throw _privateConstructorUsedError;
  @JsonKey(name: "value_tax_mission")
  String? get valueTaxMission => throw _privateConstructorUsedError;
  @JsonKey(name: "activity_nature")
  String get activityNature => throw _privateConstructorUsedError;
  @JsonKey(name: "activity_location")
  String get activityLocation => throw _privateConstructorUsedError;
  @JsonKey(name: "accounts")
  String get accounts => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  @JsonKey(name: "joining_date")
  DateTime? get joiningDate => throw _privateConstructorUsedError;
  @JsonKey(name: "natural_id")
  String? get naturalId => throw _privateConstructorUsedError;
  @JsonKey(name: "money_capitals")
  List<MoneyCapitalModel>? get moneyCapitals =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "record_side")
  String? get recordSide => throw _privateConstructorUsedError;
  @JsonKey(name: "record_number")
  String get recordNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "user_name")
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: "passport")
  String? get passport => throw _privateConstructorUsedError;
  @JsonKey(name: "verification_code")
  String? get verificationCode => throw _privateConstructorUsedError;
  @JsonKey(name: "email")
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyModelCopyWith<CompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyModelCopyWith<$Res> {
  factory $CompanyModelCopyWith(
          CompanyModel value, $Res Function(CompanyModel) then) =
      _$CompanyModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: "id")
          int? id,
      @JsonKey(name: "funders")
          List<FunderModel> funders,
      @JsonKey(name: "commercial_feature")
          String commercialFeature,
      @JsonKey(name: "is_working")
          bool isWorking,
      @JsonKey(name: "legal_entity")
          String legalEntity,
      @JsonKey(name: "file_number")
          String? fileNumber,
      @JsonKey(name: "register_number")
          String registerNumber,
      @DatetimeJsonConverter()
      @JsonKey(name: "start_date")
          DateTime startDate,
      @DatetimeJsonConverter()
      @JsonKey(name: "stop_date")
          DateTime? stopDate,
      @JsonKey(name: "general_tax_mission")
          String generalTaxMission,
      @JsonKey(name: "value_tax_mission")
          String? valueTaxMission,
      @JsonKey(name: "activity_nature")
          String activityNature,
      @JsonKey(name: "activity_location")
          String activityLocation,
      @JsonKey(name: "accounts")
          String accounts,
      @DatetimeJsonConverter()
      @JsonKey(name: "joining_date")
          DateTime? joiningDate,
      @JsonKey(name: "natural_id")
          String? naturalId,
      @JsonKey(name: "money_capitals")
          List<MoneyCapitalModel>? moneyCapitals,
      @JsonKey(name: "record_side")
          String? recordSide,
      @JsonKey(name: "record_number")
          String recordNumber,
      @JsonKey(name: "user_name")
          String userName,
      @JsonKey(name: "passport")
          String? passport,
      @JsonKey(name: "verification_code")
          String? verificationCode,
      @JsonKey(name: "email")
          String email});
}

/// @nodoc
class _$CompanyModelCopyWithImpl<$Res> implements $CompanyModelCopyWith<$Res> {
  _$CompanyModelCopyWithImpl(this._value, this._then);

  final CompanyModel _value;
  // ignore: unused_field
  final $Res Function(CompanyModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? funders = freezed,
    Object? commercialFeature = freezed,
    Object? isWorking = freezed,
    Object? legalEntity = freezed,
    Object? fileNumber = freezed,
    Object? registerNumber = freezed,
    Object? startDate = freezed,
    Object? stopDate = freezed,
    Object? generalTaxMission = freezed,
    Object? valueTaxMission = freezed,
    Object? activityNature = freezed,
    Object? activityLocation = freezed,
    Object? accounts = freezed,
    Object? joiningDate = freezed,
    Object? naturalId = freezed,
    Object? moneyCapitals = freezed,
    Object? recordSide = freezed,
    Object? recordNumber = freezed,
    Object? userName = freezed,
    Object? passport = freezed,
    Object? verificationCode = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      funders: funders == freezed
          ? _value.funders
          : funders // ignore: cast_nullable_to_non_nullable
              as List<FunderModel>,
      commercialFeature: commercialFeature == freezed
          ? _value.commercialFeature
          : commercialFeature // ignore: cast_nullable_to_non_nullable
              as String,
      isWorking: isWorking == freezed
          ? _value.isWorking
          : isWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      legalEntity: legalEntity == freezed
          ? _value.legalEntity
          : legalEntity // ignore: cast_nullable_to_non_nullable
              as String,
      fileNumber: fileNumber == freezed
          ? _value.fileNumber
          : fileNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      registerNumber: registerNumber == freezed
          ? _value.registerNumber
          : registerNumber // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stopDate: stopDate == freezed
          ? _value.stopDate
          : stopDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      generalTaxMission: generalTaxMission == freezed
          ? _value.generalTaxMission
          : generalTaxMission // ignore: cast_nullable_to_non_nullable
              as String,
      valueTaxMission: valueTaxMission == freezed
          ? _value.valueTaxMission
          : valueTaxMission // ignore: cast_nullable_to_non_nullable
              as String?,
      activityNature: activityNature == freezed
          ? _value.activityNature
          : activityNature // ignore: cast_nullable_to_non_nullable
              as String,
      activityLocation: activityLocation == freezed
          ? _value.activityLocation
          : activityLocation // ignore: cast_nullable_to_non_nullable
              as String,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as String,
      joiningDate: joiningDate == freezed
          ? _value.joiningDate
          : joiningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      naturalId: naturalId == freezed
          ? _value.naturalId
          : naturalId // ignore: cast_nullable_to_non_nullable
              as String?,
      moneyCapitals: moneyCapitals == freezed
          ? _value.moneyCapitals
          : moneyCapitals // ignore: cast_nullable_to_non_nullable
              as List<MoneyCapitalModel>?,
      recordSide: recordSide == freezed
          ? _value.recordSide
          : recordSide // ignore: cast_nullable_to_non_nullable
              as String?,
      recordNumber: recordNumber == freezed
          ? _value.recordNumber
          : recordNumber // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      passport: passport == freezed
          ? _value.passport
          : passport // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationCode: verificationCode == freezed
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CompanyModelCopyWith<$Res>
    implements $CompanyModelCopyWith<$Res> {
  factory _$$_CompanyModelCopyWith(
          _$_CompanyModel value, $Res Function(_$_CompanyModel) then) =
      __$$_CompanyModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: "id")
          int? id,
      @JsonKey(name: "funders")
          List<FunderModel> funders,
      @JsonKey(name: "commercial_feature")
          String commercialFeature,
      @JsonKey(name: "is_working")
          bool isWorking,
      @JsonKey(name: "legal_entity")
          String legalEntity,
      @JsonKey(name: "file_number")
          String? fileNumber,
      @JsonKey(name: "register_number")
          String registerNumber,
      @DatetimeJsonConverter()
      @JsonKey(name: "start_date")
          DateTime startDate,
      @DatetimeJsonConverter()
      @JsonKey(name: "stop_date")
          DateTime? stopDate,
      @JsonKey(name: "general_tax_mission")
          String generalTaxMission,
      @JsonKey(name: "value_tax_mission")
          String? valueTaxMission,
      @JsonKey(name: "activity_nature")
          String activityNature,
      @JsonKey(name: "activity_location")
          String activityLocation,
      @JsonKey(name: "accounts")
          String accounts,
      @DatetimeJsonConverter()
      @JsonKey(name: "joining_date")
          DateTime? joiningDate,
      @JsonKey(name: "natural_id")
          String? naturalId,
      @JsonKey(name: "money_capitals")
          List<MoneyCapitalModel>? moneyCapitals,
      @JsonKey(name: "record_side")
          String? recordSide,
      @JsonKey(name: "record_number")
          String recordNumber,
      @JsonKey(name: "user_name")
          String userName,
      @JsonKey(name: "passport")
          String? passport,
      @JsonKey(name: "verification_code")
          String? verificationCode,
      @JsonKey(name: "email")
          String email});
}

/// @nodoc
class __$$_CompanyModelCopyWithImpl<$Res>
    extends _$CompanyModelCopyWithImpl<$Res>
    implements _$$_CompanyModelCopyWith<$Res> {
  __$$_CompanyModelCopyWithImpl(
      _$_CompanyModel _value, $Res Function(_$_CompanyModel) _then)
      : super(_value, (v) => _then(v as _$_CompanyModel));

  @override
  _$_CompanyModel get _value => super._value as _$_CompanyModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? funders = freezed,
    Object? commercialFeature = freezed,
    Object? isWorking = freezed,
    Object? legalEntity = freezed,
    Object? fileNumber = freezed,
    Object? registerNumber = freezed,
    Object? startDate = freezed,
    Object? stopDate = freezed,
    Object? generalTaxMission = freezed,
    Object? valueTaxMission = freezed,
    Object? activityNature = freezed,
    Object? activityLocation = freezed,
    Object? accounts = freezed,
    Object? joiningDate = freezed,
    Object? naturalId = freezed,
    Object? moneyCapitals = freezed,
    Object? recordSide = freezed,
    Object? recordNumber = freezed,
    Object? userName = freezed,
    Object? passport = freezed,
    Object? verificationCode = freezed,
    Object? email = freezed,
  }) {
    return _then(_$_CompanyModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      funders: funders == freezed
          ? _value._funders
          : funders // ignore: cast_nullable_to_non_nullable
              as List<FunderModel>,
      commercialFeature: commercialFeature == freezed
          ? _value.commercialFeature
          : commercialFeature // ignore: cast_nullable_to_non_nullable
              as String,
      isWorking: isWorking == freezed
          ? _value.isWorking
          : isWorking // ignore: cast_nullable_to_non_nullable
              as bool,
      legalEntity: legalEntity == freezed
          ? _value.legalEntity
          : legalEntity // ignore: cast_nullable_to_non_nullable
              as String,
      fileNumber: fileNumber == freezed
          ? _value.fileNumber
          : fileNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      registerNumber: registerNumber == freezed
          ? _value.registerNumber
          : registerNumber // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stopDate: stopDate == freezed
          ? _value.stopDate
          : stopDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      generalTaxMission: generalTaxMission == freezed
          ? _value.generalTaxMission
          : generalTaxMission // ignore: cast_nullable_to_non_nullable
              as String,
      valueTaxMission: valueTaxMission == freezed
          ? _value.valueTaxMission
          : valueTaxMission // ignore: cast_nullable_to_non_nullable
              as String?,
      activityNature: activityNature == freezed
          ? _value.activityNature
          : activityNature // ignore: cast_nullable_to_non_nullable
              as String,
      activityLocation: activityLocation == freezed
          ? _value.activityLocation
          : activityLocation // ignore: cast_nullable_to_non_nullable
              as String,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as String,
      joiningDate: joiningDate == freezed
          ? _value.joiningDate
          : joiningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      naturalId: naturalId == freezed
          ? _value.naturalId
          : naturalId // ignore: cast_nullable_to_non_nullable
              as String?,
      moneyCapitals: moneyCapitals == freezed
          ? _value._moneyCapitals
          : moneyCapitals // ignore: cast_nullable_to_non_nullable
              as List<MoneyCapitalModel>?,
      recordSide: recordSide == freezed
          ? _value.recordSide
          : recordSide // ignore: cast_nullable_to_non_nullable
              as String?,
      recordNumber: recordNumber == freezed
          ? _value.recordNumber
          : recordNumber // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      passport: passport == freezed
          ? _value.passport
          : passport // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationCode: verificationCode == freezed
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompanyModel implements _CompanyModel {
  const _$_CompanyModel(
      {@JsonKey(name: "id")
          this.id,
      @JsonKey(name: "funders")
          required final List<FunderModel> funders,
      @JsonKey(name: "commercial_feature")
          required this.commercialFeature,
      @JsonKey(name: "is_working")
          required this.isWorking,
      @JsonKey(name: "legal_entity")
          required this.legalEntity,
      @JsonKey(name: "file_number")
          this.fileNumber,
      @JsonKey(name: "register_number")
          required this.registerNumber,
      @DatetimeJsonConverter()
      @JsonKey(name: "start_date")
          required this.startDate,
      @DatetimeJsonConverter()
      @JsonKey(name: "stop_date")
          this.stopDate,
      @JsonKey(name: "general_tax_mission")
          required this.generalTaxMission,
      @JsonKey(name: "value_tax_mission")
          this.valueTaxMission,
      @JsonKey(name: "activity_nature")
          required this.activityNature,
      @JsonKey(name: "activity_location")
          required this.activityLocation,
      @JsonKey(name: "accounts")
          required this.accounts,
      @DatetimeJsonConverter()
      @JsonKey(name: "joining_date")
          this.joiningDate,
      @JsonKey(name: "natural_id")
          this.naturalId,
      @JsonKey(name: "money_capitals")
          final List<MoneyCapitalModel>? moneyCapitals,
      @JsonKey(name: "record_side")
          this.recordSide,
      @JsonKey(name: "record_number")
          required this.recordNumber,
      @JsonKey(name: "user_name")
          required this.userName,
      @JsonKey(name: "passport")
          this.passport,
      @JsonKey(name: "verification_code")
          this.verificationCode,
      @JsonKey(name: "email")
          required this.email})
      : _funders = funders,
        _moneyCapitals = moneyCapitals;

  factory _$_CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$$_CompanyModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  final List<FunderModel> _funders;
  @override
  @JsonKey(name: "funders")
  List<FunderModel> get funders {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_funders);
  }

  @override
  @JsonKey(name: "commercial_feature")
  final String commercialFeature;
  @override
  @JsonKey(name: "is_working")
  final bool isWorking;
  @override
  @JsonKey(name: "legal_entity")
  final String legalEntity;
  @override
  @JsonKey(name: "file_number")
  final String? fileNumber;
  @override
  @JsonKey(name: "register_number")
  final String registerNumber;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: "start_date")
  final DateTime startDate;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: "stop_date")
  final DateTime? stopDate;
  @override
  @JsonKey(name: "general_tax_mission")
  final String generalTaxMission;
  @override
  @JsonKey(name: "value_tax_mission")
  final String? valueTaxMission;
  @override
  @JsonKey(name: "activity_nature")
  final String activityNature;
  @override
  @JsonKey(name: "activity_location")
  final String activityLocation;
  @override
  @JsonKey(name: "accounts")
  final String accounts;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: "joining_date")
  final DateTime? joiningDate;
  @override
  @JsonKey(name: "natural_id")
  final String? naturalId;
  final List<MoneyCapitalModel>? _moneyCapitals;
  @override
  @JsonKey(name: "money_capitals")
  List<MoneyCapitalModel>? get moneyCapitals {
    final value = _moneyCapitals;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "record_side")
  final String? recordSide;
  @override
  @JsonKey(name: "record_number")
  final String recordNumber;
  @override
  @JsonKey(name: "user_name")
  final String userName;
  @override
  @JsonKey(name: "passport")
  final String? passport;
  @override
  @JsonKey(name: "verification_code")
  final String? verificationCode;
  @override
  @JsonKey(name: "email")
  final String email;

  @override
  String toString() {
    return 'CompanyModel(id: $id, funders: $funders, commercialFeature: $commercialFeature, isWorking: $isWorking, legalEntity: $legalEntity, fileNumber: $fileNumber, registerNumber: $registerNumber, startDate: $startDate, stopDate: $stopDate, generalTaxMission: $generalTaxMission, valueTaxMission: $valueTaxMission, activityNature: $activityNature, activityLocation: $activityLocation, accounts: $accounts, joiningDate: $joiningDate, naturalId: $naturalId, moneyCapitals: $moneyCapitals, recordSide: $recordSide, recordNumber: $recordNumber, userName: $userName, passport: $passport, verificationCode: $verificationCode, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other._funders, _funders) &&
            const DeepCollectionEquality()
                .equals(other.commercialFeature, commercialFeature) &&
            const DeepCollectionEquality().equals(other.isWorking, isWorking) &&
            const DeepCollectionEquality()
                .equals(other.legalEntity, legalEntity) &&
            const DeepCollectionEquality()
                .equals(other.fileNumber, fileNumber) &&
            const DeepCollectionEquality()
                .equals(other.registerNumber, registerNumber) &&
            const DeepCollectionEquality().equals(other.startDate, startDate) &&
            const DeepCollectionEquality().equals(other.stopDate, stopDate) &&
            const DeepCollectionEquality()
                .equals(other.generalTaxMission, generalTaxMission) &&
            const DeepCollectionEquality()
                .equals(other.valueTaxMission, valueTaxMission) &&
            const DeepCollectionEquality()
                .equals(other.activityNature, activityNature) &&
            const DeepCollectionEquality()
                .equals(other.activityLocation, activityLocation) &&
            const DeepCollectionEquality().equals(other.accounts, accounts) &&
            const DeepCollectionEquality()
                .equals(other.joiningDate, joiningDate) &&
            const DeepCollectionEquality().equals(other.naturalId, naturalId) &&
            const DeepCollectionEquality()
                .equals(other._moneyCapitals, _moneyCapitals) &&
            const DeepCollectionEquality()
                .equals(other.recordSide, recordSide) &&
            const DeepCollectionEquality()
                .equals(other.recordNumber, recordNumber) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.passport, passport) &&
            const DeepCollectionEquality()
                .equals(other.verificationCode, verificationCode) &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(_funders),
        const DeepCollectionEquality().hash(commercialFeature),
        const DeepCollectionEquality().hash(isWorking),
        const DeepCollectionEquality().hash(legalEntity),
        const DeepCollectionEquality().hash(fileNumber),
        const DeepCollectionEquality().hash(registerNumber),
        const DeepCollectionEquality().hash(startDate),
        const DeepCollectionEquality().hash(stopDate),
        const DeepCollectionEquality().hash(generalTaxMission),
        const DeepCollectionEquality().hash(valueTaxMission),
        const DeepCollectionEquality().hash(activityNature),
        const DeepCollectionEquality().hash(activityLocation),
        const DeepCollectionEquality().hash(accounts),
        const DeepCollectionEquality().hash(joiningDate),
        const DeepCollectionEquality().hash(naturalId),
        const DeepCollectionEquality().hash(_moneyCapitals),
        const DeepCollectionEquality().hash(recordSide),
        const DeepCollectionEquality().hash(recordNumber),
        const DeepCollectionEquality().hash(userName),
        const DeepCollectionEquality().hash(passport),
        const DeepCollectionEquality().hash(verificationCode),
        const DeepCollectionEquality().hash(email)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_CompanyModelCopyWith<_$_CompanyModel> get copyWith =>
      __$$_CompanyModelCopyWithImpl<_$_CompanyModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompanyModelToJson(
      this,
    );
  }
}

abstract class _CompanyModel implements CompanyModel {
  const factory _CompanyModel(
      {@JsonKey(name: "id")
          final int? id,
      @JsonKey(name: "funders")
          required final List<FunderModel> funders,
      @JsonKey(name: "commercial_feature")
          required final String commercialFeature,
      @JsonKey(name: "is_working")
          required final bool isWorking,
      @JsonKey(name: "legal_entity")
          required final String legalEntity,
      @JsonKey(name: "file_number")
          final String? fileNumber,
      @JsonKey(name: "register_number")
          required final String registerNumber,
      @DatetimeJsonConverter()
      @JsonKey(name: "start_date")
          required final DateTime startDate,
      @DatetimeJsonConverter()
      @JsonKey(name: "stop_date")
          final DateTime? stopDate,
      @JsonKey(name: "general_tax_mission")
          required final String generalTaxMission,
      @JsonKey(name: "value_tax_mission")
          final String? valueTaxMission,
      @JsonKey(name: "activity_nature")
          required final String activityNature,
      @JsonKey(name: "activity_location")
          required final String activityLocation,
      @JsonKey(name: "accounts")
          required final String accounts,
      @DatetimeJsonConverter()
      @JsonKey(name: "joining_date")
          final DateTime? joiningDate,
      @JsonKey(name: "natural_id")
          final String? naturalId,
      @JsonKey(name: "money_capitals")
          final List<MoneyCapitalModel>? moneyCapitals,
      @JsonKey(name: "record_side")
          final String? recordSide,
      @JsonKey(name: "record_number")
          required final String recordNumber,
      @JsonKey(name: "user_name")
          required final String userName,
      @JsonKey(name: "passport")
          final String? passport,
      @JsonKey(name: "verification_code")
          final String? verificationCode,
      @JsonKey(name: "email")
          required final String email}) = _$_CompanyModel;

  factory _CompanyModel.fromJson(Map<String, dynamic> json) =
      _$_CompanyModel.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "funders")
  List<FunderModel> get funders;
  @override
  @JsonKey(name: "commercial_feature")
  String get commercialFeature;
  @override
  @JsonKey(name: "is_working")
  bool get isWorking;
  @override
  @JsonKey(name: "legal_entity")
  String get legalEntity;
  @override
  @JsonKey(name: "file_number")
  String? get fileNumber;
  @override
  @JsonKey(name: "register_number")
  String get registerNumber;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: "start_date")
  DateTime get startDate;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: "stop_date")
  DateTime? get stopDate;
  @override
  @JsonKey(name: "general_tax_mission")
  String get generalTaxMission;
  @override
  @JsonKey(name: "value_tax_mission")
  String? get valueTaxMission;
  @override
  @JsonKey(name: "activity_nature")
  String get activityNature;
  @override
  @JsonKey(name: "activity_location")
  String get activityLocation;
  @override
  @JsonKey(name: "accounts")
  String get accounts;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: "joining_date")
  DateTime? get joiningDate;
  @override
  @JsonKey(name: "natural_id")
  String? get naturalId;
  @override
  @JsonKey(name: "money_capitals")
  List<MoneyCapitalModel>? get moneyCapitals;
  @override
  @JsonKey(name: "record_side")
  String? get recordSide;
  @override
  @JsonKey(name: "record_number")
  String get recordNumber;
  @override
  @JsonKey(name: "user_name")
  String get userName;
  @override
  @JsonKey(name: "passport")
  String? get passport;
  @override
  @JsonKey(name: "verification_code")
  String? get verificationCode;
  @override
  @JsonKey(name: "email")
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyModelCopyWith<_$_CompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}
