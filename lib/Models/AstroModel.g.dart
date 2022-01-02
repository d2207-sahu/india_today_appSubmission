// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AstroModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AstroModel _$AstroModelFromJson(Map<String, dynamic> json) => AstroModel(
      json['firstName'] as String?,
      json['urlSlug'] as String?,
      json['lastName'] as String?,
      json['namePrefix'] as String?,
      json['aboutMe'] as String?,
      json['profliePicUrl'] as String?,
      json['availability'] as Map<String, dynamic>?,
      json['isOnCall'] as bool?,
      json['freeMinutes'] as int?,
      json['additionalMinute'] as int?,
      json['minimumCallDuration'] as int?,
      json['id'] as int?,
      (json['rating'] as num?)?.toDouble(),
      (json['minimumCallDurationCharges'] as num?)?.toDouble(),
      (json['additionalPerMinuteCharges'] as num?)?.toDouble(),
      (json['experience'] as num?)?.toDouble(),
      json['images'] as Map<String, dynamic>?,
      json['skills'] as List<dynamic>?,
      json['languages'] as List<dynamic>?,
    );

Map<String, dynamic> _$AstroModelToJson(AstroModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'urlSlug': instance.urlSlug,
      'lastName': instance.lastName,
      'namePrefix': instance.namePrefix,
      'aboutMe': instance.aboutMe,
      'profliePicUrl': instance.profliePicUrl,
      'availability': instance.availability,
      'isOnCall': instance.isOnCall,
      'freeMinutes': instance.freeMinutes,
      'additionalMinute': instance.additionalMinute,
      'minimumCallDuration': instance.minimumCallDuration,
      'id': instance.id,
      'rating': instance.rating,
      'minimumCallDurationCharges': instance.minimumCallDurationCharges,
      'additionalPerMinuteCharges': instance.additionalPerMinuteCharges,
      'experience': instance.experience,
      'images': instance.images,
      'skills': instance.skills,
      'languages': instance.languages,
    };
