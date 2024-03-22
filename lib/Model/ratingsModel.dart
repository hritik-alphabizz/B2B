// To parse this JSON data, do
//
//     final ratingsModel = ratingsModelFromJson(jsonString);

import 'dart:convert';

RatingsModel ratingsModelFromJson(String str) =>
    RatingsModel.fromJson(json.decode(str));

String ratingsModelToJson(RatingsModel data) => json.encode(data.toJson());

class RatingsModel {
  bool? error;
  String? message;
  int? noOfRating;
  String? total;
  String? star1;
  String? star2;
  String? star3;
  String? star4;
  String? star5;
  String? totalImages;
  String? productRating;
  List<Datum>? data;

  RatingsModel({
    this.error,
    this.message,
    this.noOfRating,
    this.total,
    this.star1,
    this.star2,
    this.star3,
    this.star4,
    this.star5,
    this.totalImages,
    this.productRating,
    this.data,
  });

  factory RatingsModel.fromJson(Map<String, dynamic> json) => RatingsModel(
        error: json["error"],
        message: json["message"],
        noOfRating: json["no_of_rating"],
        total: json["total"],
        star1: json["star_1"],
        star2: json["star_2"],
        star3: json["star_3"],
        star4: json["star_4"],
        star5: json["star_5"],
        totalImages: json["total_images"],
        productRating: json["product_rating"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "no_of_rating": noOfRating,
        "total": total,
        "star_1": star1,
        "star_2": star2,
        "star_3": star3,
        "star_4": star4,
        "star_5": star5,
        "total_images": totalImages,
        "product_rating": productRating,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? userId;
  String? productId;
  String? rating;
  List<dynamic>? images;
  String? comment;
  String? dataAdded;
  String? userName;
  String? userProfile;

  Datum({
    this.id,
    this.userId,
    this.productId,
    this.rating,
    this.images,
    this.comment,
    this.dataAdded,
    this.userName,
    this.userProfile,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        rating: json["rating"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        comment: json["comment"],
        dataAdded: json["data_added"],
        userName: json["user_name"],
        userProfile: json["user_profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "rating": rating,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "comment": comment,
        "data_added": dataAdded,
        "user_name": userName,
        "user_profile": userProfile,
      };
}
