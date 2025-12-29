// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paytr_installment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayTRInstallmentOptionImpl _$$PayTRInstallmentOptionImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRInstallmentOptionImpl(
      month: (json['month'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
      monthlyAmount: (json['monthlyAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$PayTRInstallmentOptionImplToJson(
        _$PayTRInstallmentOptionImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'rate': instance.rate,
      'monthlyAmount': instance.monthlyAmount,
      'totalAmount': instance.totalAmount,
    };

_$PayTRBankInstallmentsImpl _$$PayTRBankInstallmentsImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRBankInstallmentsImpl(
      bankCode: json['bankCode'] as String,
      options: (json['options'] as List<dynamic>)
          .map(
              (e) => PayTRInstallmentOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PayTRBankInstallmentsImplToJson(
        _$PayTRBankInstallmentsImpl instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'options': instance.options,
    };

_$PayTRInstallmentsResponseImpl _$$PayTRInstallmentsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRInstallmentsResponseImpl(
      success: json['success'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
      banks: (json['banks'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, PayTRBankInstallments.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      allOptions: (json['allOptions'] as List<dynamic>?)
              ?.map((e) =>
                  PayTRInstallmentOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PayTRInstallmentsResponseImplToJson(
        _$PayTRInstallmentsResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage,
      'banks': instance.banks,
      'allOptions': instance.allOptions,
    };
