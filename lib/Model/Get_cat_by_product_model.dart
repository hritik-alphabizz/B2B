// To parse this JSON data, do
//
//     final getCatByProductModel = getCatByProductModelFromJson(jsonString);

import 'dart:convert';

GetCatByProductModel getCatByProductModelFromJson(String str) =>
    GetCatByProductModel.fromJson(json.decode(str));

String getCatByProductModelToJson(GetCatByProductModel data) =>
    json.encode(data.toJson());

class GetCatByProductModel {
  bool? status;
  List<dataListHome>? data;

  GetCatByProductModel({
    this.status,
    this.data,
  });

  factory GetCatByProductModel.fromJson(Map<String, dynamic> json) =>
      GetCatByProductModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<dataListHome>.from(
                json["data"]!.map((x) => dataListHome.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class dataListHome {
  String? id;
  String? name;
  String? parentId;
  String? slug;
  String? image;
  String? banner;
  String? rowOrder;
  String? status;
  String? clicks;
  List<dataListHome>? subcategories;
  List<Product>? products;

  dataListHome({
    this.id,
    this.name,
    this.parentId,
    this.slug,
    this.image,
    this.banner,
    this.rowOrder,
    this.status,
    this.clicks,
    this.subcategories,
    this.products,
  });

  factory dataListHome.fromJson(Map<String, dynamic> json) => dataListHome(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        slug: json["slug"],
        image: json["image"],
        banner: json["banner"],
        rowOrder: json["row_order"],
        status: json["status"],
        clicks: json["clicks"],
        subcategories: json["subcategories"] == null
            ? []
            : List<dataListHome>.from(
                json["subcategories"]!.map((x) => dataListHome.fromJson(x))),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "slug": slug,
        "image": image,
        "banner": banner,
        "row_order": rowOrder,
        "status": status,
        "clicks": clicks,
        "subcategories": subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  String? id;
  String? userId;
  String? slug;
  dynamic categoryIds;
  String? storeName;
  String? storeDescription;
  String? logo;
  String? storeUrl;
  String? noOfRatings;
  String? rating;
  String? bankName;
  String? bankCode;
  String? accountName;
  String? accountNumber;
  String? nationalIdentityCard;
  String? addressProof;
  String? authorizedSignature;
  String? panNumber;
  String? taxName;
  String? taxNumber;
  String? permissions;
  String? commission;
  String? status;
  String? dateAdded;
  String? udyogNum;
  String? partner;
  String? otherNumber;
  String? partnerNumber;
  String? companyAddress;
  String? facebook;
  String? instagram;
  String? webLink;
  String? linkedin;
  String? purchaseId;
  String? sellerCategoryId;
  String? partnerAddress;
  dynamic ipAddress;
  String? username;
  String? password;
  dynamic normalPassword;
  String? email;
  String? mobile;
  String? image;
  String? balance;
  String? activationSelector;
  String? activationCode;
  dynamic forgottenPasswordSelector;
  dynamic forgottenPasswordCode;
  dynamic forgottenPasswordTime;
  dynamic rememberSelector;
  dynamic rememberCode;
  String? createdOn;
  String? lastLogin;
  dynamic active;
  String? company;
  String? address;
  String? bonusType;
  dynamic bonus;
  String? cashReceived;
  dynamic dob;
  dynamic countryCode;
  String? city;
  String? destrict;
  String? area;
  dynamic street;
  String? pincode;
  dynamic serviceableZipcodes;
  dynamic apikey;
  dynamic referralCode;
  dynamic friendsCode;
  dynamic fcmId;
  String? latitude;
  String? longitude;
  String? type;
  String? createdAt;
  dynamic userType;
  String? typeOfSeller;
  String? state;
  String? country;
  String? subscriptionType;
  String? otp;
  String? broucher;
  dynamic media;
  String? cityName;
  String? productId;
  dynamic attributeValueIds;
  dynamic attributeSet;
  String? price;
  String? specialPrice;
  dynamic sku;
  dynamic stock;
  String? weight;
  String? height;
  String? breadth;
  String? length;
  dynamic images;
  dynamic availability;
  String? color;
  String? packete;
  dynamic productIdentity;
  String? categoryId;
  String? sellerId;
  String? tax;
  String? rowOrder;
  dynamic stockType;
  String? name;
  String? shortDescription;
  String? indicator;
  String? codAllowed;
  String? downloadAllowed;
  String? downloadType;
  String? downloadLink;
  String? minimumOrderQuantity;
  String? quantityStepSize;
  String? totalAllowedQuantity;
  String? isPricesInclusiveTax;
  String? isReturnable;
  String? isCancelable;
  String? cancelableTill;
  List<dynamic>? otherImages;
  List<String>? broucherImage;
  String? videoType;
  String? video;
  String? tags;
  String? warrantyPeriod;
  String? guaranteePeriod;
  String? madeIn;
  String? hsnCode;
  String? brand;
  String? description;
  String? extraDescription;
  String? deliverableType;
  dynamic deliverableZipcodes;
  dynamic? pickupLocation;
  String? subCatId;
  String? attributeTitle;
  String? attributeValue;
  String? productImage;
//  ProductImageOthers? productImageOthers;
  List<dynamic>? broucherImageSm;
  List<dynamic>? broucherImageMd;
  List<dynamic>? otherImagesSm;
  List<dynamic>? otherImagesMd;

  Product({
    this.id,
    this.userId,
    this.slug,
    this.categoryIds,
    this.storeName,
    this.storeDescription,
    this.logo,
    this.storeUrl,
    this.noOfRatings,
    this.rating,
    this.bankName,
    this.bankCode,
    this.accountName,
    this.accountNumber,
    this.nationalIdentityCard,
    this.addressProof,
    this.authorizedSignature,
    this.panNumber,
    this.taxName,
    this.taxNumber,
    this.permissions,
    this.commission,
    this.status,
    this.dateAdded,
    this.udyogNum,
    this.partner,
    this.otherNumber,
    this.partnerNumber,
    this.companyAddress,
    this.facebook,
    this.instagram,
    this.webLink,
    this.linkedin,
    this.purchaseId,
    this.sellerCategoryId,
    this.partnerAddress,
    this.ipAddress,
    this.username,
    this.password,
    this.normalPassword,
    this.email,
    this.mobile,
    this.image,
    this.balance,
    this.activationSelector,
    this.activationCode,
    this.forgottenPasswordSelector,
    this.forgottenPasswordCode,
    this.forgottenPasswordTime,
    this.rememberSelector,
    this.rememberCode,
    this.createdOn,
    this.lastLogin,
    this.active,
    this.company,
    this.address,
    this.bonusType,
    this.bonus,
    this.cashReceived,
    this.dob,
    this.countryCode,
    this.city,
    this.destrict,
    this.area,
    this.street,
    this.pincode,
    this.serviceableZipcodes,
    this.apikey,
    this.referralCode,
    this.friendsCode,
    this.fcmId,
    this.latitude,
    this.longitude,
    this.type,
    this.createdAt,
    this.userType,
    this.typeOfSeller,
    this.state,
    this.country,
    this.subscriptionType,
    this.otp,
    this.broucher,
    this.media,
    this.cityName,
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
    this.color,
    this.packete,
    this.productIdentity,
    this.categoryId,
    this.sellerId,
    this.tax,
    this.rowOrder,
    this.stockType,
    this.name,
    this.shortDescription,
    this.indicator,
    this.codAllowed,
    this.downloadAllowed,
    this.downloadType,
    this.downloadLink,
    this.minimumOrderQuantity,
    this.quantityStepSize,
    this.totalAllowedQuantity,
    this.isPricesInclusiveTax,
    this.isReturnable,
    this.isCancelable,
    this.cancelableTill,
    this.otherImages,
    this.broucherImage,
    this.videoType,
    this.video,
    this.tags,
    this.warrantyPeriod,
    this.guaranteePeriod,
    this.madeIn,
    this.hsnCode,
    this.brand,
    this.description,
    this.extraDescription,
    this.deliverableType,
    this.deliverableZipcodes,
    this.pickupLocation,
    this.subCatId,
    this.attributeTitle,
    this.attributeValue,
    this.productImage,
    // this.productImageOthers,
    this.broucherImageSm,
    this.broucherImageMd,
    this.otherImagesSm,
    this.otherImagesMd,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        userId: json["user_id"],
        slug: json["slug"],
        categoryIds: json["category_ids"],
        storeName: json["store_name"],
        storeDescription: json["store_description"],
        logo: json["logo"],
        storeUrl: json["store_url"],
        noOfRatings: json["no_of_ratings"],
        rating: json["rating"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        nationalIdentityCard: json["national_identity_card"],
        addressProof: json["address_proof"],
        authorizedSignature: json["authorized_signature"],
        panNumber: json["pan_number"],
        taxName: json["tax_name"] ?? "",
        taxNumber: json["tax_number"],
        permissions: json["permissions"],
        commission: json["commission"],
        status: json["status"],
        dateAdded: json["date_added"],
        udyogNum: json["udyog_num"],
        partner: json["partner"],
        otherNumber: json["other_number"],
        partnerNumber: json["partner_number"],
        companyAddress: json["company_address"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        webLink: json["web_link"],
        linkedin: json["linkedin"],
        purchaseId: json["purchase_id"],
        sellerCategoryId: json["seller_category_id"],
        partnerAddress: json["partner_address"] ?? "",
        ipAddress: json["ip_address"] ?? "",
        username: json["username"],
        password: json["password"],
        normalPassword: json["normal_password"],
        email: json["email"],
        mobile: json["mobile"],
        image: json["image"],
        balance: json["balance"],
        activationSelector: json["activation_selector"],
        activationCode: json["activation_code"],
        forgottenPasswordSelector: json["forgotten_password_selector"],
        forgottenPasswordCode: json["forgotten_password_code"],
        forgottenPasswordTime: json["forgotten_password_time"],
        rememberSelector: json["remember_selector"],
        rememberCode: json["remember_code"],
        createdOn: json["created_on"],
        lastLogin: json["last_login"],
        active: json["active"],
        company: json["company"],
        address: json["address"],
        bonusType: json["bonus_type"] ?? "",
        bonus: json["bonus"],
        cashReceived: json["cash_received"],
        dob: json["dob"],
        countryCode: json["country_code"],
        city: json["city"],
        destrict: json["destrict"] ?? "",
        area: json["area"],
        street: json["street"],
        pincode: json["pincode"],
        serviceableZipcodes: json["serviceable_zipcodes"],
        apikey: json["apikey"],
        referralCode: json["referral_code"],
        friendsCode: json["friends_code"],
        fcmId: json["fcm_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"] ?? "",
        createdAt: json["created_at"],
        userType: json["user_type"],
        typeOfSeller: json["type_of_seller"] ?? "",
        state: json["state"],
        country: json["country"],
        subscriptionType: json["subscription_type"],
        otp: json["otp"],
        broucher: json["broucher"],
        media: json["media"],
        cityName: json["city_name"],
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
        images: json["images"],
        availability: json["availability"],
        color: json["color"],
        packete: json["packete"],
        productIdentity: json["product_identity"],
        categoryId: json["category_id"],
        sellerId: json["seller_id"],
        tax: json["tax"],
        rowOrder: json["row_order"],
        stockType: json["stock_type"],
        name: json["name"],
        shortDescription: json["short_description"],
        indicator: json["indicator"],
        codAllowed: json["cod_allowed"],
        downloadAllowed: json["download_allowed"],
        downloadType: json["download_type"],
        downloadLink: json["download_link"],
        minimumOrderQuantity: json["minimum_order_quantity"],
        quantityStepSize: json["quantity_step_size"],
        totalAllowedQuantity: json["total_allowed_quantity"],
        isPricesInclusiveTax: json["is_prices_inclusive_tax"],
        isReturnable: json["is_returnable"],
        isCancelable: json["is_cancelable"],
        cancelableTill: json["cancelable_till"],
        otherImages: json["other_images"] == null
            ? []
            : List<dynamic>.from(json["other_images"]!.map((x) => x)),
        broucherImage: json["broucher_image"] == null
            ? []
            : List<String>.from(json["broucher_image"]!.map((x) => x)),
        videoType: json["video_type"] ?? "",
        video: json["video"],
        tags: json["tags"],
        warrantyPeriod: json["warranty_period"] ?? "",
        guaranteePeriod: json["guarantee_period"] ?? "",
        madeIn: json["made_in"],
        hsnCode: json["hsn_code"],
        brand: json["brand"],
        description: json["description"],
        extraDescription: json["extra_description"],
        deliverableType: json["deliverable_type"],
        deliverableZipcodes: json["deliverable_zipcodes"],
        pickupLocation: json["pickup_location"] ?? "",
        subCatId: json["sub_cat_id"],
        attributeTitle: json["attribute_title"],
        attributeValue: json["attribute_value"],
        productImage: json["product_image"],
        // productImageOthers:
        //     productImageOthersValues.map[json["product_image_others"]]!,
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "slug": slug,
        "category_ids": categoryIds,
        "store_name": storeName,
        "store_description": storeDescription,
        "logo": logo,
        "store_url": storeUrl,
        "no_of_ratings": noOfRatings,
        "rating": rating,
        "bank_name": bankName,
        "bank_code": bankCode,
        "account_name": accountName,
        "account_number": accountNumber,
        "national_identity_card": nationalIdentityCard,
        "address_proof": addressProof,
        "authorized_signature": authorizedSignature,
        "pan_number": panNumber,
        "tax_name": taxName,
        "tax_number": taxNumber,
        "permissions": permissions,
        "commission": commission,
        "status": status,
        "date_added": dateAdded,
        "udyog_num": udyogNum,
        "partner": partner,
        "other_number": otherNumber,
        "partner_number": partnerNumber,
        "company_address": companyAddress,
        "facebook": facebook,
        "instagram": instagram,
        "web_link": webLink,
        "linkedin": linkedin,
        "purchase_id": purchaseId,
        "seller_category_id": sellerCategoryId,
        "partner_address": partnerAddress,
        "ip_address": ipAddress,
        "username": username,
        "password": password,
        "normal_password": normalPassword,
        "email": email,
        "mobile": mobile,
        "image": image,
        "balance": balance,
        "activation_selector": activationSelector,
        "activation_code": activationCode,
        "forgotten_password_selector": forgottenPasswordSelector,
        "forgotten_password_code": forgottenPasswordCode,
        "forgotten_password_time": forgottenPasswordTime,
        "remember_selector": rememberSelector,
        "remember_code": rememberCode,
        "created_on": createdOn,
        "last_login": lastLogin,
        "active": active,
        "company": company,
        "address": address,
        "bonus_type": bonusType,
        "bonus": bonus,
        "cash_received": cashReceived,
        "dob": dob,
        "country_code": countryCode,
        "city": city,
        "destrict": destrict,
        "area": area,
        "street": street,
        "pincode": pincode,
        "serviceable_zipcodes": serviceableZipcodes,
        "apikey": apikey,
        "referral_code": referralCode,
        "friends_code": friendsCode,
        "fcm_id": fcmId,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
        "created_at": createdAt,
        "user_type": userType,
        "type_of_seller": typeOfSeller,
        "state": state,
        "country": country,
        "subscription_type": subscriptionType,
        "otp": otp,
        "broucher": broucher,
        "media": media,
        "city_name": cityName,
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
        "images": images,
        "availability": availability,
        "color": color,
        "packete": packete,
        "product_identity": productIdentity,
        "category_id": categoryId,
        "seller_id": sellerId,
        "tax": tax,
        "row_order": rowOrder,
        "stock_type": stockType,
        "name": name,
        "short_description": shortDescription,
        "indicator": indicator,
        "cod_allowed": codAllowed,
        "download_allowed": downloadAllowed,
        "download_type": downloadType,
        "download_link": downloadLink,
        "minimum_order_quantity": minimumOrderQuantity,
        "quantity_step_size": quantityStepSize,
        "total_allowed_quantity": totalAllowedQuantity,
        "is_prices_inclusive_tax": isPricesInclusiveTax,
        "is_returnable": isReturnable,
        "is_cancelable": isCancelable,
        "cancelable_till": cancelableTill,
        "other_images": otherImages == null
            ? []
            : List<dynamic>.from(otherImages!.map((x) => x)),
        "broucher_image": broucherImage == null
            ? []
            : List<String>.from(broucherImage!.map((x) => x)),
        "video_type": videoType,
        "video": video,
        "tags": tags,
        "warranty_period": warrantyPeriod,
        "guarantee_period": guaranteePeriod,
        "made_in": madeIn,
        "hsn_code": hsnCode,
        "brand": brand,
        "description": description,
        "extra_description": extraDescription,
        "deliverable_type": deliverableType,
        "deliverable_zipcodes": deliverableZipcodes,
        "pickup_location": pickupLocation,
        "sub_cat_id": subCatId,
        "attribute_title": attributeTitle,
        "attribute_value": attributeValue,
        "product_image": productImage,
        // "product_image_others":
        //     productImageOthersValues.reverse[productImageOthers],
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
      };
}
