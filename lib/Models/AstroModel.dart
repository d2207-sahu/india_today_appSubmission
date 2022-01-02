import 'package:json_annotation/json_annotation.dart';
part 'AstroModel.g.dart';
// {
//             "id": 4689,
//             "urlSlug": "suniti-jha",
//             "namePrefix": null,
//             "firstName": "Suniti",
//             "lastName": "Jha",
//             "aboutMe": "Astrologer",
//             "profliePicUrl": null,
//             "experience": 7.0,
//             "languages": [
//                 {
//                     "id": 1,
//                     "name": "Hindi"
//                 },
//                 {
//                     "id": 2,
//                     "name": "English"
//                 }
//             ],
//             "minimumCallDuration": 5,
//             "minimumCallDurationCharges": 200.0,
//             "additionalPerMinuteCharges": 40.0,
//             "isAvailable": true,
//             "rating": null,
//             "skills": [
//                 {
//                     "id": 6,
//                     "name": "Falit Jyotish",
//                     "description": ""
//                 },
//                 {
//                     "id": 7,
//                     "name": "Kundali Grah Dosh",
//                     "description": ""
//                 },
//                 {
//                     "id": 2,
//                     "name": "Vastu",
//                     "description": ""
//                 },
//                 {
//                     "id": 8,
//                     "name": "Vedic Astrology",
//                     "description": ""
//                 },
//                 {
//                     "id": 1,
//                     "name": "Astrology",
//                     "description": ""
//                 },
//                 {
//                     "id": 4,
//                     "name": "Palmistry",
//                     "description": ""
//                 },
//                 {
//                     "id": 3,
//                     "name": "Numerology",
//                     "description": ""
//                 },
//                 {
//                     "id": 5,
//                     "name": "Tarot",
//                     "description": ""
//                 }
//             ],
// ///           "isOnCall": false,
//             "freeMinutes": 0,
//             "additionalMinute": 1,
//             "images": {
//                 "small": {
//                     "imageUrl": null,
//                     "id": null
//                 },
//                 "large": {
//                     "imageUrl": "https://tak-astrotak-av.s3.ap-south-1.amazonaws.com/astro-images/agents/880X918-Sunita-jha.jpg",
//                     "id": 98
//                 },
//                 "medium": {
//                     "imageUrl": "https://tak-astrotak-av.s3.ap-south-1.amazonaws.com/astro-images/agents/740X502-Sunita-jha.jpg",
//                     "id": 161
//                 }
//             },
//  ///           "availability": {
//                 "days": [
//                     "MON",
//                     "TUE",
//                     "WED",
//                     "THU",
//                     "FRI",
//                     "SAT",
//                     "SUN"
//                 ],
//                 "slot": {
//                     "toFormat": "PM",
//                     "fromFormat": "AM",
//                     "from": "11",
//                     "to": "5"
//                 }
//             }
//         },

@JsonSerializable(explicitToJson: true)
class AstroModel {
  String? firstName, urlSlug, lastName, namePrefix, aboutMe, profliePicUrl;
  Map? availability;
  bool? isOnCall;
  int? freeMinutes, additionalMinute, minimumCallDuration, id;
  double? rating,
      minimumCallDurationCharges,
      additionalPerMinuteCharges,
      experience;
  Map? images;
  List? skills, languages;

  AstroModel(
      this.firstName,
      this.urlSlug,
      this.lastName,
      this.namePrefix,
      this.aboutMe,
      this.profliePicUrl,
      this.availability,
      this.isOnCall,
      this.freeMinutes,
      this.additionalMinute,
      this.minimumCallDuration,
      this.id,
      this.rating,
      this.minimumCallDurationCharges,
      this.additionalPerMinuteCharges,
      this.experience,
      this.images,
      this.skills,
      this.languages);

  factory AstroModel.fromJson(Map<String, dynamic> json) =>
      _$AstroModelFromJson(json);

  Map<String, dynamic> toJson() => _$AstroModelToJson(this);
}
