// To parse this JSON data, do
//
//     final getHomeProductsModel = getHomeProductsModelFromJson(jsonString);

import 'dart:convert';

GetHomeProductsModel getHomeProductsModelFromJson(String str) =>
    GetHomeProductsModel.fromJson(json.decode(str));

String getHomeProductsModelToJson(GetHomeProductsModel data) =>
    json.encode(data.toJson());

class GetHomeProductsModel {
  bool? error;
  String? message;
  String? minPrice;
  String? maxPrice;
  String? search;
  List<Filter>? filters;
  List<String>? tags;
  String? total;
  String? offset;
  List<Datum>? data;

  GetHomeProductsModel({
    this.error,
    this.message,
    this.minPrice,
    this.maxPrice,
    this.search,
    this.filters,
    this.tags,
    this.total,
    this.offset,
    this.data,
  });

  factory GetHomeProductsModel.fromJson(Map<String, dynamic> json) =>
      GetHomeProductsModel(
        error: json["error"],
        message: json["message"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        search: json["search"],
        filters: json["filters"] == null
            ? []
            : List<Filter>.from(
                json["filters"]!.map((x) => Filter.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        total: json["total"],
        offset: json["offset"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "min_price": minPrice,
        "max_price": maxPrice,
        "search": search,
        "filters": filters == null
            ? []
            : List<dynamic>.from(filters!.map((x) => x.toJson())),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "total": total,
        "offset": offset,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? total;
  String? sales;
  String? stockType;
  String? isPricesInclusiveTax;
  Type? type;
  String? attrValueIds;
  String? sellerRating;
  String? sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  String? storeName;
  String? storeDescription;
  String? sellerId;
  String? sellerName;
  String? sellerAddress;
  String? id;
  String? stock;
  String? name;
  String? categoryId;
  String? shortDescription;
  String? slug;
  String? description;
  String? extraDescription;
  String? totalAllowedQuantity;
  String? status;
  String? deliverableType;
  String? deliverableZipcodes;
  String? minimumOrderQuantity;
  String? sku;
  String? quantityStepSize;
  String? codAllowed;
  String? rowOrder;
  String? rating;
  String? noOfRatings;
  String? image;
  String? isReturnable;
  String? isCancelable;
  String? cancelableTill;
  String? indicator;
  List<String>? otherImages;
  VideoType? videoType;
  String? video;
  List<String>? tags;
  Period? warrantyPeriod;
  Period? guaranteePeriod;
  MadeIn? madeIn;
  String? hsnCode;
  String? downloadAllowed;
  String? downloadType;
  String? downloadLink;
  String? pickupLocation;
  Brand? brand;
  String? availability;
  String? categoryName;
  String? taxPercentage;
  String? taxId;
  List<dynamic>? broucherImage;
  List<ReviewImage>? reviewImages;
  List<Attribute>? attributes;
  List<Variant>? variants;
  String? totalStock;
  MinMaxPrice? minMaxPrice;
  String? address;
  String? relativePath;
  List<String>? otherImagesRelativePath;
  String? videoRelativePath;
  String? totalProduct;
  String? deliverableZipcodesIds;
  bool? isDeliverable;
  bool? isPurchased;
  String? isFavorite;
  String? imageMd;
  String? imageSm;
  List<dynamic>? broucherImageSm;
  List<dynamic>? broucherImageMd;
  List<String>? otherImagesSm;
  List<String>? otherImagesMd;
  List<dynamic>? variantAttributes;

  Datum({
    this.total,
    this.sales,
    this.stockType,
    this.isPricesInclusiveTax,
    this.type,
    this.attrValueIds,
    this.sellerRating,
    this.sellerSlug,
    this.sellerNoOfRatings,
    this.sellerProfile,
    this.storeName,
    this.storeDescription,
    this.sellerId,
    this.sellerName,
    this.sellerAddress,
    this.id,
    this.stock,
    this.name,
    this.categoryId,
    this.shortDescription,
    this.slug,
    this.description,
    this.extraDescription,
    this.totalAllowedQuantity,
    this.status,
    this.deliverableType,
    this.deliverableZipcodes,
    this.minimumOrderQuantity,
    this.sku,
    this.quantityStepSize,
    this.codAllowed,
    this.rowOrder,
    this.rating,
    this.noOfRatings,
    this.image,
    this.isReturnable,
    this.isCancelable,
    this.cancelableTill,
    this.indicator,
    this.otherImages,
    this.videoType,
    this.video,
    this.tags,
    this.warrantyPeriod,
    this.guaranteePeriod,
    this.madeIn,
    this.hsnCode,
    this.downloadAllowed,
    this.downloadType,
    this.downloadLink,
    this.pickupLocation,
    this.brand,
    this.availability,
    this.categoryName,
    this.taxPercentage,
    this.taxId,
    this.broucherImage,
    this.reviewImages,
    this.attributes,
    this.variants,
    this.totalStock,
    this.minMaxPrice,
    this.address,
    this.relativePath,
    this.otherImagesRelativePath,
    this.videoRelativePath,
    this.totalProduct,
    this.deliverableZipcodesIds,
    this.isDeliverable,
    this.isPurchased,
    this.isFavorite,
    this.imageMd,
    this.imageSm,
    this.broucherImageSm,
    this.broucherImageMd,
    this.otherImagesSm,
    this.otherImagesMd,
    this.variantAttributes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        total: json["total"],
        sales: json["sales"],
        stockType: json["stock_type"],
        isPricesInclusiveTax: json["is_prices_inclusive_tax"],
        type: typeValues.map[json["type"]]!,
        attrValueIds: json["attr_value_ids"],
        sellerRating: json["seller_rating"],
        sellerSlug: json["seller_slug"],
        sellerNoOfRatings: json["seller_no_of_ratings"],
        sellerProfile: json["seller_profile"],
        storeName: json["store_name"],
        storeDescription: json["store_description"],
        sellerId: json["seller_id"],
        sellerName: json["seller_name"],
        sellerAddress: json["seller_address"],
        id: json["id"],
        stock: json["stock"],
        name: json["name"],
        categoryId: json["category_id"],
        shortDescription: json["short_description"],
        slug: json["slug"],
        description: json["description"],
        extraDescription: json["extra_description"],
        totalAllowedQuantity: json["total_allowed_quantity"],
        status: json["status"],
        deliverableType: json["deliverable_type"],
        deliverableZipcodes: json["deliverable_zipcodes"],
        minimumOrderQuantity: json["minimum_order_quantity"],
        sku: json["sku"],
        quantityStepSize: json["quantity_step_size"],
        codAllowed: json["cod_allowed"],
        rowOrder: json["row_order"],
        rating: json["rating"],
        noOfRatings: json["no_of_ratings"],
        image: json["image"],
        isReturnable: json["is_returnable"],
        isCancelable: json["is_cancelable"],
        cancelableTill: json["cancelable_till"],
        indicator: json["indicator"],
        otherImages: json["other_images"] == null
            ? []
            : List<String>.from(json["other_images"]!.map((x) => x)),
        videoType: videoTypeValues.map[json["video_type"]]!,
        video: json["video"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        warrantyPeriod: periodValues.map[json["warranty_period"]]!,
        guaranteePeriod: periodValues.map[json["guarantee_period"]]!,
        madeIn: madeInValues.map[json["made_in"]]!,
        hsnCode: json["hsn_code"],
        downloadAllowed: json["download_allowed"],
        downloadType: json["download_type"],
        downloadLink: json["download_link"],
        pickupLocation: json["pickup_location"],
        brand: brandValues.map[json["brand"]]!,
        availability: json["availability"],
        categoryName: json["category_name"],
        taxPercentage: json["tax_percentage"],
        taxId: json["tax_id"],
        broucherImage: json["broucher_image"] == null
            ? []
            : List<dynamic>.from(json["broucher_image"]!.map((x) => x)),
        reviewImages: json["review_images"] == null
            ? []
            : List<ReviewImage>.from(
                json["review_images"]!.map((x) => ReviewImage.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        totalStock: json["total_stock"],
        minMaxPrice: json["min_max_price"] == null
            ? null
            : MinMaxPrice.fromJson(json["min_max_price"]),
        address: json["address"],
        relativePath: json["relative_path"],
        otherImagesRelativePath: json["other_images_relative_path"] == null
            ? []
            : List<String>.from(
                json["other_images_relative_path"]!.map((x) => x)),
        videoRelativePath: json["video_relative_path"],
        totalProduct: json["total_product"],
        deliverableZipcodesIds: json["deliverable_zipcodes_ids"],
        isDeliverable: json["is_deliverable"],
        isPurchased: json["is_purchased"],
        isFavorite: json["is_favorite"],
        imageMd: json["image_md"],
        imageSm: json["image_sm"],
        broucherImageSm: json["broucher_image_sm"] == null
            ? []
            : List<dynamic>.from(json["broucher_image_sm"]!.map((x) => x)),
        broucherImageMd: json["broucher_image_md"] == null
            ? []
            : List<dynamic>.from(json["broucher_image_md"]!.map((x) => x)),
        otherImagesSm: json["other_images_sm"] == null
            ? []
            : List<String>.from(json["other_images_sm"]!.map((x) => x)),
        otherImagesMd: json["other_images_md"] == null
            ? []
            : List<String>.from(json["other_images_md"]!.map((x) => x)),
        variantAttributes: json["variant_attributes"] == null
            ? []
            : List<dynamic>.from(json["variant_attributes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "sales": sales,
        "stock_type": stockType,
        "is_prices_inclusive_tax": isPricesInclusiveTax,
        "type": typeValues.reverse[type],
        "attr_value_ids": attrValueIds,
        "seller_rating": sellerRating,
        "seller_slug": sellerSlug,
        "seller_no_of_ratings": sellerNoOfRatings,
        "seller_profile": sellerProfile,
        "store_name": storeName,
        "store_description": storeDescription,
        "seller_id": sellerId,
        "seller_name": sellerName,
        "seller_address": sellerAddress,
        "id": id,
        "stock": stock,
        "name": name,
        "category_id": categoryId,
        "short_description": shortDescription,
        "slug": slug,
        "description": description,
        "extra_description": extraDescription,
        "total_allowed_quantity": totalAllowedQuantity,
        "status": status,
        "deliverable_type": deliverableType,
        "deliverable_zipcodes": deliverableZipcodes,
        "minimum_order_quantity": minimumOrderQuantity,
        "sku": sku,
        "quantity_step_size": quantityStepSize,
        "cod_allowed": codAllowed,
        "row_order": rowOrder,
        "rating": rating,
        "no_of_ratings": noOfRatings,
        "image": image,
        "is_returnable": isReturnable,
        "is_cancelable": isCancelable,
        "cancelable_till": cancelableTill,
        "indicator": indicator,
        "other_images": otherImages == null
            ? []
            : List<dynamic>.from(otherImages!.map((x) => x)),
        "video_type": videoTypeValues.reverse[videoType],
        "video": video,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "warranty_period": periodValues.reverse[warrantyPeriod],
        "guarantee_period": periodValues.reverse[guaranteePeriod],
        "made_in": madeInValues.reverse[madeIn],
        "hsn_code": hsnCode,
        "download_allowed": downloadAllowed,
        "download_type": downloadType,
        "download_link": downloadLink,
        "pickup_location": pickupLocation,
        "brand": brandValues.reverse[brand],
        "availability": availability,
        "category_name": categoryName,
        "tax_percentage": taxPercentage,
        "tax_id": taxId,
        "broucher_image": broucherImage == null
            ? []
            : List<dynamic>.from(broucherImage!.map((x) => x)),
        "review_images": reviewImages == null
            ? []
            : List<dynamic>.from(reviewImages!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "total_stock": totalStock,
        "min_max_price": minMaxPrice?.toJson(),
        "address": address,
        "relative_path": relativePath,
        "other_images_relative_path": otherImagesRelativePath == null
            ? []
            : List<dynamic>.from(otherImagesRelativePath!.map((x) => x)),
        "video_relative_path": videoRelativePath,
        "total_product": totalProduct,
        "deliverable_zipcodes_ids": deliverableZipcodesIds,
        "is_deliverable": isDeliverable,
        "is_purchased": isPurchased,
        "is_favorite": isFavorite,
        "image_md": imageMd,
        "image_sm": imageSm,
        "broucher_image_sm": broucherImageSm == null
            ? []
            : List<dynamic>.from(broucherImageSm!.map((x) => x)),
        "broucher_image_md": broucherImageMd == null
            ? []
            : List<dynamic>.from(broucherImageMd!.map((x) => x)),
        "other_images_sm": otherImagesSm == null
            ? []
            : List<dynamic>.from(otherImagesSm!.map((x) => x)),
        "other_images_md": otherImagesMd == null
            ? []
            : List<dynamic>.from(otherImagesMd!.map((x) => x)),
        "variant_attributes": variantAttributes == null
            ? []
            : List<dynamic>.from(variantAttributes!.map((x) => x)),
      };
}

class Attribute {
  String? ids;
  String? value;
  String? attrName;
  String? name;
  String? swatcheType;
  String? swatcheValue;

  Attribute({
    this.ids,
    this.value,
    this.attrName,
    this.name,
    this.swatcheType,
    this.swatcheValue,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        ids: json["ids"],
        value: json["value"],
        attrName: json["attr_name"],
        name: json["name"],
        swatcheType: json["swatche_type"],
        swatcheValue: json["swatche_value"],
      );

  Map<String, dynamic> toJson() => {
        "ids": ids,
        "value": value,
        "attr_name": attrName,
        "name": name,
        "swatche_type": swatcheType,
        "swatche_value": swatcheValue,
      };
}

enum Brand { ADIDAS, EMPTY }

final brandValues = EnumValues({"adidas": Brand.ADIDAS, "": Brand.EMPTY});

enum Period { EMPTY, THE_1_MONTH }

final periodValues =
    EnumValues({"": Period.EMPTY, "1 month": Period.THE_1_MONTH});

enum MadeIn { EMPTY, IND }

final madeInValues = EnumValues({"": MadeIn.EMPTY, "ind": MadeIn.IND});

class MinMaxPrice {
  int? minPrice;
  int? maxPrice;
  int? specialPrice;
  int? maxSpecialPrice;
  int? discountInPercentage;

  MinMaxPrice({
    this.minPrice,
    this.maxPrice,
    this.specialPrice,
    this.maxSpecialPrice,
    this.discountInPercentage,
  });

  factory MinMaxPrice.fromJson(Map<String, dynamic> json) => MinMaxPrice(
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        specialPrice: json["special_price"],
        maxSpecialPrice: json["max_special_price"],
        discountInPercentage: json["discount_in_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "min_price": minPrice,
        "max_price": maxPrice,
        "special_price": specialPrice,
        "max_special_price": maxSpecialPrice,
        "discount_in_percentage": discountInPercentage,
      };
}

class ReviewImage {
  String? totalImages;
  String? totalReviewsWithImages;
  String? noOfRating;
  String? totalReviews;
  String? star1;
  String? star2;
  String? star3;
  String? star4;
  String? star5;
  List<ProductRating>? productRating;

  ReviewImage({
    this.totalImages,
    this.totalReviewsWithImages,
    this.noOfRating,
    this.totalReviews,
    this.star1,
    this.star2,
    this.star3,
    this.star4,
    this.star5,
    this.productRating,
  });

  factory ReviewImage.fromJson(Map<String, dynamic> json) => ReviewImage(
        totalImages: json["total_images"],
        totalReviewsWithImages: json["total_reviews_with_images"],
        noOfRating: json["no_of_rating"],
        totalReviews: json["total_reviews"],
        star1: json["star_1"],
        star2: json["star_2"],
        star3: json["star_3"],
        star4: json["star_4"],
        star5: json["star_5"],
        productRating: json["product_rating"] == null
            ? []
            : List<ProductRating>.from(
                json["product_rating"]!.map((x) => ProductRating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_images": totalImages,
        "total_reviews_with_images": totalReviewsWithImages,
        "no_of_rating": noOfRating,
        "total_reviews": totalReviews,
        "star_1": star1,
        "star_2": star2,
        "star_3": star3,
        "star_4": star4,
        "star_5": star5,
        "product_rating": productRating == null
            ? []
            : List<dynamic>.from(productRating!.map((x) => x.toJson())),
      };
}

class ProductRating {
  String? id;
  String? userId;
  String? productId;
  String? rating;
  List<String>? images;
  String? comment;
  DateTime? dataAdded;
  String? userName;
  String? userProfile;

  ProductRating({
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

  factory ProductRating.fromJson(Map<String, dynamic> json) => ProductRating(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        rating: json["rating"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        comment: json["comment"],
        dataAdded: json["data_added"] == null
            ? null
            : DateTime.parse(json["data_added"]),
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
        "data_added": dataAdded?.toIso8601String(),
        "user_name": userName,
        "user_profile": userProfile,
      };
}

enum Type { SIMPLE_PRODUCT }

final typeValues = EnumValues({"simple_product": Type.SIMPLE_PRODUCT});

class Variant {
  String? id;
  String? productId;
  String? attributeValueIds;
  String? attributeSet;
  String? price;
  String? specialPrice;
  String? sku;
  String? stock;
  String? weight;
  String? height;
  String? breadth;
  String? length;
  List<dynamic>? images;
  String? availability;
  String? status;
  DateTime? dateAdded;
  String? color;
  String? packete;
  String? variantIds;
  String? attrName;
  String? variantValues;
  String? swatcheType;
  String? swatcheValue;
  List<dynamic>? imagesMd;
  List<dynamic>? imagesSm;
  List<dynamic>? variantRelativePath;
  String? cartCount;

  Variant({
    this.id,
    this.productId,
    this.attributeValueIds,
    this.attributeSet,
    this.price,
    this.specialPrice,
    this.sku,
    this.stock,
    this.weight,
    this.height,
    this.breadth,
    this.length,
    this.images,
    this.availability,
    this.status,
    this.dateAdded,
    this.color,
    this.packete,
    this.variantIds,
    this.attrName,
    this.variantValues,
    this.swatcheType,
    this.swatcheValue,
    this.imagesMd,
    this.imagesSm,
    this.variantRelativePath,
    this.cartCount,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        productId: json["product_id"],
        attributeValueIds: json["attribute_value_ids"],
        attributeSet: json["attribute_set"],
        price: json["price"],
        specialPrice: json["special_price"],
        sku: json["sku"],
        stock: json["stock"],
        weight: json["weight"],
        height: json["height"],
        breadth: json["breadth"],
        length: json["length"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        availability: json["availability"],
        status: json["status"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        color: json["color"],
        packete: json["packete"],
        variantIds: json["variant_ids"],
        attrName: json["attr_name"],
        variantValues: json["variant_values"],
        swatcheType: json["swatche_type"],
        swatcheValue: json["swatche_value"],
        imagesMd: json["images_md"] == null
            ? []
            : List<dynamic>.from(json["images_md"]!.map((x) => x)),
        imagesSm: json["images_sm"] == null
            ? []
            : List<dynamic>.from(json["images_sm"]!.map((x) => x)),
        variantRelativePath: json["variant_relative_path"] == null
            ? []
            : List<dynamic>.from(json["variant_relative_path"]!.map((x) => x)),
        cartCount: json["cart_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "attribute_value_ids": attributeValueIds,
        "attribute_set": attributeSet,
        "price": price,
        "special_price": specialPrice,
        "sku": sku,
        "stock": stock,
        "weight": weight,
        "height": height,
        "breadth": breadth,
        "length": length,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "availability": availability,
        "status": status,
        "date_added": dateAdded?.toIso8601String(),
        "color": color,
        "packete": packete,
        "variant_ids": variantIds,
        "attr_name": attrName,
        "variant_values": variantValues,
        "swatche_type": swatcheType,
        "swatche_value": swatcheValue,
        "images_md":
            imagesMd == null ? [] : List<dynamic>.from(imagesMd!.map((x) => x)),
        "images_sm":
            imagesSm == null ? [] : List<dynamic>.from(imagesSm!.map((x) => x)),
        "variant_relative_path": variantRelativePath == null
            ? []
            : List<dynamic>.from(variantRelativePath!.map((x) => x)),
        "cart_count": cartCount,
      };
}

enum VideoType { EMPTY, YOUTUBE }

final videoTypeValues =
    EnumValues({"": VideoType.EMPTY, "youtube": VideoType.YOUTUBE});

class Filter {
  String? attributeValues;
  String? attributeValuesId;
  String? name;
  String? swatcheType;
  String? swatcheValue;

  Filter({
    this.attributeValues,
    this.attributeValuesId,
    this.name,
    this.swatcheType,
    this.swatcheValue,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        attributeValues: json["attribute_values"],
        attributeValuesId: json["attribute_values_id"],
        name: json["name"],
        swatcheType: json["swatche_type"],
        swatcheValue: json["swatche_value"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_values": attributeValues,
        "attribute_values_id": attributeValuesId,
        "name": name,
        "swatche_type": swatcheType,
        "swatche_value": swatcheValue,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
