// To parse this JSON data, do
//
//     final addPropertyRequestModel = addPropertyRequestModelFromJson(jsonString);

import 'dart:convert';

GetPropertyResponseModel addPropertyRequestModelFromJson(String str) => GetPropertyResponseModel.fromJson(json.decode(str));

String addPropertyRequestModelToJson(GetPropertyResponseModel data) => json.encode(data.toJson());

class GetPropertyResponseModel {


  GetPropertyResponseModel({
    required this.userId,
    required this.propId,
    required this.propName,
    required this.propOwnerName,
    required this.propOwnerType,
    required this.propAddress,
    required this.propDescription,
    required this.propImageOne,
    required this.propImageTwo,
    required this.propImageThree,
    required this.propImageFour,
    required this.propImageFive,
  });

  String userId;
  String propId;
  String propName;
  String propOwnerName;
  String propOwnerType;
  String propAddress;
  String propDescription;
  String propImageOne;
  String propImageTwo;
  String propImageThree;
  String propImageFour;
  String propImageFive;

  factory GetPropertyResponseModel.fromJson(Map<String, dynamic> json) => GetPropertyResponseModel(
    propId: json["prop_id"],
    userId: json["user_id"],
    propName: json["prop_name"],
    propOwnerName: json["prop_owner_name"],
    propOwnerType: json["prop_owner_type"],
    propAddress: json["prop_address"],
    propDescription: json["prop_description"],
    propImageOne: json["prop_image_one"],
    propImageTwo: json["prop_image_two"],
    propImageThree: json["prop_image_three"],
    propImageFour: json["prop_image_four"],
    propImageFive: json["prop_image_five"],
  );

  Map<String, dynamic> toJson() => {
    "prop_id": propId,
    "user_id": userId,
    "prop_name": propName,
    "prop_owner_name": propOwnerName,
    "prop_owner_type": propOwnerType,
    "prop_address": propAddress,
    "prop_description": propDescription,
    "prop_image_one": propImageOne,
    "prop_image_two": propImageTwo,
    "prop_image_three": propImageThree,
    "prop_image_four": propImageFour,
    "prop_image_five": propImageFive,
  };
}
