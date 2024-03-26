// To parse this JSON data, do
//
//     final getHomeProductDetailsModel = getHomeProductDetailsModelFromJson(jsonString);

import 'dart:convert';

GetHomeProductDetailsModel getHomeProductDetailsModelFromJson(String str) =>
    GetHomeProductDetailsModel.fromJson(json.decode(str));

String getHomeProductDetailsModelToJson(GetHomeProductDetailsModel data) =>
    json.encode(data.toJson());

class GetHomeProductDetailsModel {
  bool? error;
  String? message;
  String? minPrice;
  String? maxPrice;
  String? search;
  List<Filter>? filters;
  List<String>? tags;
  String? total;
  String? offset;
  List<dynamic>? subcategories;
  List<Datum>? data;

  GetHomeProductDetailsModel({
    this.error,
    this.message,
    this.minPrice,
    this.maxPrice,
    this.search,
    this.filters,
    this.tags,
    this.total,
    this.offset,
    this.subcategories,
    this.data,
  });

  factory GetHomeProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetHomeProductDetailsModel(
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
        subcategories: json["subcategories"] == null
            ? []
            : List<dynamic>.from(json["subcategories"]!.map((x) => x)),
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
        "subcategories": subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x)),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? total;
  String? sales;
  dynamic stockType;
  String? isPricesInclusiveTax;
  String? type;
  String? attrValueIds;
  String? email;
  String? sellerRating;
  dynamic sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  String? storeName;
  String? storeDescription;
  String? sellerId;
  String? sellerName;
  String? id;
  dynamic stock;
  String? name;
  String? categoryId;
  String? shortDescription;
  String? extraDescription;
  String? slug;
  String? description;
  String? totalAllowedQuantity;
  String? deliverableType;
  dynamic deliverableZipcodes;
  String? minimumOrderQuantity;
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
  String? videoType;
  String? video;
  List<String>? tags;
  String? taxNumber;
  String? latitude;
  String? longitude;
  String? webLink;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? subscriptionType;
  String? warrantyPeriod;
  String? attributeTitle;
  String? attributeValue;
  String? brand;
  String? subCatId;
  String? address;
  String? typeOfSeller;
  String? stateName;
  dynamic countryName;
  String? pincode;
  String? destrict;
  String? city;
  String? area;
  dynamic street;
  String? country;
  String? guaranteePeriod;
  List<String>? broucherImage;
  String? madeIn;
  dynamic availability;
  String? categoryName;
  String? subCatName;
  String? taxPercentage;
  List<dynamic>? reviewImages;
  List<Attribute>? attributes;
  List<Variant>? variants;
  MinMaxPrice? minMaxPrice;
  dynamic deliverableZipcodesIds;
  List<ProductDatum>? productData;
  bool? isDeliverable;
  bool? isPurchased;
  String? isFavorite;
  String? imageMd;
  String? imageSm;
  List<String>? broucherImageMd;
  List<String>? broucherImageSm;
  List<String>? otherImagesMd;
  List<String>? otherImagesSm;
  List<dynamic>? variantAttributes;

  Datum({
    this.total,
    this.sales,
    this.stockType,
    this.isPricesInclusiveTax,
    this.type,
    this.attrValueIds,
    this.email,
    this.sellerRating,
    this.sellerSlug,
    this.sellerNoOfRatings,
    this.sellerProfile,
    this.storeName,
    this.storeDescription,
    this.sellerId,
    this.sellerName,
    this.id,
    this.stock,
    this.name,
    this.categoryId,
    this.shortDescription,
    this.extraDescription,
    this.slug,
    this.description,
    this.totalAllowedQuantity,
    this.deliverableType,
    this.deliverableZipcodes,
    this.minimumOrderQuantity,
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
    this.taxNumber,
    this.latitude,
    this.longitude,
    this.webLink,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.subscriptionType,
    this.warrantyPeriod,
    this.attributeTitle,
    this.attributeValue,
    this.brand,
    this.subCatId,
    this.address,
    this.typeOfSeller,
    this.stateName,
    this.countryName,
    this.pincode,
    this.destrict,
    this.city,
    this.area,
    this.street,
    this.country,
    this.guaranteePeriod,
    this.broucherImage,
    this.madeIn,
    this.availability,
    this.categoryName,
    this.subCatName,
    this.taxPercentage,
    this.reviewImages,
    this.attributes,
    this.variants,
    this.minMaxPrice,
    this.deliverableZipcodesIds,
    this.productData,
    this.isDeliverable,
    this.isPurchased,
    this.isFavorite,
    this.imageMd,
    this.imageSm,
    this.broucherImageMd,
    this.broucherImageSm,
    this.otherImagesMd,
    this.otherImagesSm,
    this.variantAttributes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        total: json["total"],
        sales: json["sales"],
        stockType: json["stock_type"],
        isPricesInclusiveTax: json["is_prices_inclusive_tax"],
        type: json["type"],
        attrValueIds: json["attr_value_ids"],
        email: json["email"],
        sellerRating: json["seller_rating"],
        sellerSlug: json["seller_slug"],
        sellerNoOfRatings: json["seller_no_of_ratings"],
        sellerProfile: json["seller_profile"],
        storeName: json["store_name"],
        storeDescription: json["store_description"],
        sellerId: json["seller_id"],
        sellerName: json["seller_name"],
        id: json["id"],
        stock: json["stock"],
        name: json["name"],
        categoryId: json["category_id"],
        shortDescription: json["short_description"],
        extraDescription: json["extra_description"],
        slug: json["slug"],
        description: json["description"],
        totalAllowedQuantity: json["total_allowed_quantity"],
        deliverableType: json["deliverable_type"],
        deliverableZipcodes: json["deliverable_zipcodes"],
        minimumOrderQuantity: json["minimum_order_quantity"],
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
        videoType: json["video_type"],
        video: json["video"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        taxNumber: json["tax_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        webLink: json["web_link"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        linkedin: json["linkedin"],
        subscriptionType: json["subscription_type"],
        warrantyPeriod: json["warranty_period"],
        attributeTitle: json["attribute_title"],
        attributeValue: json["attribute_value"],
        brand: json["brand"],
        subCatId: json["sub_cat_id"],
        address: json["address"],
        typeOfSeller: json["type_of_seller"],
        stateName: json["state_name"],
        countryName: json["country_name"],
        pincode: json["pincode"],
        destrict: json["destrict"],
        city: json["city"],
        area: json["area"],
        street: json["street"],
        country: json["country"],
        guaranteePeriod: json["guarantee_period"],
        broucherImage: json["broucher_image"] == null
            ? []
            : List<String>.from(json["broucher_image"]!.map((x) => x)),
        madeIn: json["made_in"],
        availability: json["availability"],
        categoryName: json["category_name"],
        subCatName: json["sub_cat_name"],
        taxPercentage: json["tax_percentage"],
        reviewImages: json["review_images"] == null
            ? []
            : List<dynamic>.from(json["review_images"]!.map((x) => x)),
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        minMaxPrice: json["min_max_price"] == null
            ? null
            : MinMaxPrice.fromJson(json["min_max_price"]),
        deliverableZipcodesIds: json["deliverable_zipcodes_ids"],
        productData: json["product_data"] == null
            ? []
            : List<ProductDatum>.from(
                json["product_data"]!.map((x) => ProductDatum.fromJson(x))),
        isDeliverable: json["is_deliverable"],
        isPurchased: json["is_purchased"],
        isFavorite: json["is_favorite"],
        imageMd: json["image_md"],
        imageSm: json["image_sm"],
        broucherImageMd: json["broucher_image_md"] == null
            ? []
            : List<String>.from(json["broucher_image_md"]!.map((x) => x)),
        broucherImageSm: json["broucher_image_sm"] == null
            ? []
            : List<String>.from(json["broucher_image_sm"]!.map((x) => x)),
        otherImagesMd: json["other_images_md"] == null
            ? []
            : List<String>.from(json["other_images_md"]!.map((x) => x)),
        otherImagesSm: json["other_images_sm"] == null
            ? []
            : List<String>.from(json["other_images_sm"]!.map((x) => x)),
        variantAttributes: json["variant_attributes"] == null
            ? []
            : List<dynamic>.from(json["variant_attributes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "sales": sales,
        "stock_type": stockType,
        "is_prices_inclusive_tax": isPricesInclusiveTax,
        "type": type,
        "attr_value_ids": attrValueIds,
        "email": email,
        "seller_rating": sellerRating,
        "seller_slug": sellerSlug,
        "seller_no_of_ratings": sellerNoOfRatings,
        "seller_profile": sellerProfile,
        "store_name": storeName,
        "store_description": storeDescription,
        "seller_id": sellerId,
        "seller_name": sellerName,
        "id": id,
        "stock": stock,
        "name": name,
        "category_id": categoryId,
        "short_description": shortDescription,
        "extra_description": extraDescription,
        "slug": slug,
        "description": description,
        "total_allowed_quantity": totalAllowedQuantity,
        "deliverable_type": deliverableType,
        "deliverable_zipcodes": deliverableZipcodes,
        "minimum_order_quantity": minimumOrderQuantity,
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
        "video_type": videoType,
        "video": video,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "tax_number": taxNumber,
        "latitude": latitude,
        "longitude": longitude,
        "web_link": webLink,
        "facebook": facebook,
        "instagram": instagram,
        "linkedin": linkedin,
        "subscription_type": subscriptionType,
        "warranty_period": warrantyPeriod,
        "attribute_title": attributeTitle,
        "attribute_value": attributeValue,
        "brand": brand,
        "sub_cat_id": subCatId,
        "address": address,
        "type_of_seller": typeOfSeller,
        "state_name": stateName,
        "country_name": countryName,
        "pincode": pincode,
        "destrict": destrict,
        "city": city,
        "area": area,
        "street": street,
        "country": country,
        "guarantee_period": guaranteePeriod,
        "broucher_image": broucherImage == null
            ? []
            : List<dynamic>.from(broucherImage!.map((x) => x)),
        "made_in": madeIn,
        "availability": availability,
        "category_name": categoryName,
        "sub_cat_name": subCatName,
        "tax_percentage": taxPercentage,
        "review_images": reviewImages == null
            ? []
            : List<dynamic>.from(reviewImages!.map((x) => x)),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "min_max_price": minMaxPrice?.toJson(),
        "deliverable_zipcodes_ids": deliverableZipcodesIds,
        "product_data": productData == null
            ? []
            : List<dynamic>.from(productData!.map((x) => x.toJson())),
        "is_deliverable": isDeliverable,
        "is_purchased": isPurchased,
        "is_favorite": isFavorite,
        "image_md": imageMd,
        "image_sm": imageSm,
        "broucher_image_md": broucherImageMd == null
            ? []
            : List<dynamic>.from(broucherImageMd!.map((x) => x)),
        "broucher_image_sm": broucherImageSm == null
            ? []
            : List<dynamic>.from(broucherImageSm!.map((x) => x)),
        "other_images_md": otherImagesMd == null
            ? []
            : List<dynamic>.from(otherImagesMd!.map((x) => x)),
        "other_images_sm": otherImagesSm == null
            ? []
            : List<dynamic>.from(otherImagesSm!.map((x) => x)),
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

class ProductDatum {
  String? title;
  String? value;

  ProductDatum({
    this.title,
    this.value,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        title: json["title"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}

class Variant {
  String? id;
  String? productId;
  String? attributeValueIds;
  String? attributeSet;
  String? price;
  String? specialPrice;
  String? sku;
  dynamic stock;
  String? weight;
  String? height;
  String? breadth;
  String? length;
  List<dynamic>? images;
  String? availability;
  String? status;
  String? dateAdded;
  String? color;
  String? packete;
  String? variantIds;
  String? attrName;
  String? variantValues;
  String? swatcheType;
  String? swatcheValue;
  List<dynamic>? imagesMd;
  List<dynamic>? imagesSm;
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
        dateAdded: json["date_added"],
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
        "date_added": dateAdded,
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
        "cart_count": cartCount,
      };
}

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
