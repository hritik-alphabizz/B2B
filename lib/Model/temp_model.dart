class TempModel {
  String? total;
  String? sales;
  String? stockType;
  String? isPricesInclusiveTax;
  String? type;
  String? attrValueIds;
  String? sellerRating;
  String? sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  String? storeName;
  String? storeDescription;
  String? typeOfSeller;
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
  String? city;
  String? deliverableZipcodes;
  String? minimumOrderQuantity;
  String? sku;
  String? quantityStepSize;
  String? codAllowed;
  String? rowOrder;
  String? rating;
  String? email;
  String? noOfRatings;
  String? image;
  String? isReturnable;
  String? isCancelable;
  String? cancelableTill;
  String? indicator;
  List<dynamic>? otherImages;
  String? videoType;
  String? video;
  List<String>? tags;
  String? taxNumber;
  String? subscriptionType;
  String? latitude;
  String? longitude;
  String? warrantyPeriod;
  String? guaranteePeriod;
  String? madeIn;
  String? hsnCode;
  String? downloadAllowed;
  String? downloadType;
  String? downloadLink;
  String? pickupLocation;
  String? brand;
  String? availability;
  String? categoryName;
  String? taxPercentage;
  String? taxId;
  List<dynamic>? broucherImage;
  List<Attribute>? attributes;
  List<Variant>? variants;
  String? totalStock;
  MinMaxPrice? minMaxPrice;
  String? address;
  String? relativePath;
  List<dynamic>? otherImagesRelativePath;
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
  List<dynamic>? otherImagesSm;
  List<dynamic>? otherImagesMd;
  List<dynamic>? variantAttributes;

  TempModel({
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
    this.typeOfSeller,
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
    this.city,
    this.deliverableZipcodes,
    this.minimumOrderQuantity,
    this.sku,
    this.quantityStepSize,
    this.codAllowed,
    this.rowOrder,
    this.rating,
    this.email,
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
    this.subscriptionType,
    this.latitude,
    this.longitude,
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

  factory TempModel.fromJson(Map<String, dynamic> json) => TempModel(
        total: json["total"],
        sales: json["sales"],
        stockType: json["stock_type"],
        isPricesInclusiveTax: json["is_prices_inclusive_tax"],
        type: json["type"]!,
        attrValueIds: json["attr_value_ids"],
        sellerRating: json["seller_rating"],
        sellerSlug: json["seller_slug"],
        sellerNoOfRatings: json["seller_no_of_ratings"],
        sellerProfile: json["seller_profile"],
        storeName: json["store_name"],
        storeDescription: json["store_description"],
        typeOfSeller: json["type_of_seller"]!,
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
        city: json["city"]!,
        deliverableZipcodes: json["deliverable_zipcodes"],
        minimumOrderQuantity: json["minimum_order_quantity"],
        sku: json["sku"],
        quantityStepSize: json["quantity_step_size"],
        codAllowed: json["cod_allowed"],
        rowOrder: json["row_order"],
        rating: json["rating"],
        email: json["email"],
        noOfRatings: json["no_of_ratings"],
        image: json["image"],
        isReturnable: json["is_returnable"],
        isCancelable: json["is_cancelable"],
        cancelableTill: json["cancelable_till"],
        indicator: json["indicator"],
        otherImages: json["other_images"] == null
            ? []
            : List<dynamic>.from(json["other_images"]!.map((x) => x)),
        videoType: json["video_type"]!,
        video: json["video"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        taxNumber: json["tax_number"],
        subscriptionType: json["subscription_type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        warrantyPeriod: json["warranty_period"]!,
        guaranteePeriod: json["guarantee_period"]!,
        madeIn: json["made_in"]!,
        hsnCode: json["hsn_code"],
        downloadAllowed: json["download_allowed"],
        downloadType: json["download_type"],
        downloadLink: json["download_link"],
        pickupLocation: json["pickup_location"],
        brand: json["brand"]!,
        availability: json["availability"],
        categoryName: json["category_name"],
        taxPercentage: json["tax_percentage"],
        taxId: json["tax_id"],
        broucherImage: json["broucher_image"] == null
            ? []
            : List<dynamic>.from(json["broucher_image"]!.map((x) => x)),
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
            : List<dynamic>.from(
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
            : List<dynamic>.from(json["other_images_sm"]!.map((x) => x)),
        otherImagesMd: json["other_images_md"] == null
            ? []
            : List<dynamic>.from(json["other_images_md"]!.map((x) => x)),
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
        "seller_rating": sellerRating,
        "seller_slug": sellerSlug,
        "seller_no_of_ratings": sellerNoOfRatings,
        "seller_profile": sellerProfile,
        "store_name": storeName,
        "store_description": storeDescription,
        "type_of_seller": typeOfSeller,
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
        "city": city,
        "deliverable_zipcodes": deliverableZipcodes,
        "minimum_order_quantity": minimumOrderQuantity,
        "sku": sku,
        "quantity_step_size": quantityStepSize,
        "cod_allowed": codAllowed,
        "row_order": rowOrder,
        "rating": rating,
        "email": email,
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
        "subscription_type": subscriptionType,
        "latitude": latitude,
        "longitude": longitude,
        "warranty_period": warrantyPeriod,
        "guarantee_period": guaranteePeriod,
        "made_in": madeIn,
        "hsn_code": hsnCode,
        "download_allowed": downloadAllowed,
        "download_type": downloadType,
        "download_link": downloadLink,
        "pickup_location": pickupLocation,
        "brand": brand,
        "availability": availability,
        "category_name": categoryName,
        "tax_percentage": taxPercentage,
        "tax_id": taxId,
        "broucher_image": broucherImage == null
            ? []
            : List<dynamic>.from(broucherImage!.map((x) => x)),
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

class TempMode2 {
  List<TempModel>? temp;
  String? catName;

  TempMode2({this.temp, this.catName});
}
