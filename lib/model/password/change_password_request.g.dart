// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePassWordRequest _$ChangePassWordRequestFromJson(
    Map<String, dynamic> json) {
  return ChangePassWordRequest(
    oldPass: json['oldPass'] as String,
    newPass: json['newPass'] as String,
  );
}

Map<String, dynamic> _$ChangePassWordRequestToJson(
        ChangePassWordRequest instance) =>
    <String, dynamic>{
      'oldPass': instance.oldPass,
      'newPass': instance.newPass,
    };
