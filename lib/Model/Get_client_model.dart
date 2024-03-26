/// error : false
/// message : "Products retrieved successfully !"
/// filters : []
/// total : ""
/// offset : "0"

class GetClientModel {
  GetClientModel({
    bool? error,
    String? message,
    List<dynamic>? filters,
    String? total,
    String? offset,
    List<dataListClient>? data,
  }) {
    _error = error;
    _message = message;
    _filters = filters;
    _total = total;
    _offset = offset;
    _data = data;
  }

  GetClientModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['filters'] != null) {
      _filters = [];
      json['filters'].forEach((v) {
        _filters?.add(v.fromJson(v));
      });
    }
    _total = json['total'];
    _offset = json['offset'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(dataListClient.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<dynamic>? _filters;
  String? _total;
  String? _offset;
  List<dataListClient>? _data;
  GetClientModel copyWith({
    bool? error,
    String? message,
    List<dynamic>? filters,
    String? total,
    String? offset,
    List<dataListClient>? data,
  }) =>
      GetClientModel(
        error: error ?? _error,
        message: message ?? _message,
        filters: filters ?? _filters,
        total: total ?? _total,
        offset: offset ?? _offset,
        data: data ?? _data,
      );
  bool? get error => _error;
  String? get message => _message;
  List<dynamic>? get filters => _filters;
  String? get total => _total;
  String? get offset => _offset;
  List<dataListClient>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_filters != null) {
      map['filters'] = _filters?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    map['offset'] = _offset;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// category_name : "Plastic"

class dataListClient {
  dataListClient({
    String? categoryName,
    List<VendorData>? vendorData,
  }) {
    _categoryName = categoryName;
    _vendorData = vendorData;
  }

  dataListClient.fromJson(dynamic json) {
    _categoryName = json['category_name'];
    if (json['vendor_data'] != null) {
      _vendorData = [];
      json['vendor_data'].forEach((v) {
        _vendorData?.add(VendorData.fromJson(v));
      });
    }
  }
  String? _categoryName;
  List<VendorData>? _vendorData;
  dataListClient copyWith({
    String? categoryName,
    List<VendorData>? vendorData,
  }) =>
      dataListClient(
        categoryName: categoryName ?? _categoryName,
        vendorData: vendorData ?? _vendorData,
      );
  String? get categoryName => _categoryName;
  List<VendorData>? get vendorData => _vendorData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_name'] = _categoryName;
    if (_vendorData != null) {
      map['vendor_data'] = _vendorData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// seller_id : "515"
/// seller_info : {"id":"515","ip_address":null,"username":"Harish","password":"","normal_password":null,"email":"harish@gmail.com","mobile":"7855777747","image":null,"balance":"0","activation_selector":null,"activation_code":null,"forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"0","last_login":"1697031824","active":null,"company":null,"address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","bonus_type":"percentage_per_order","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"city":"Indore","destrict":"indore","area":"vijay nagar","street":null,"pincode":"452010","serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":null,"latitude":"22.7533","longitude":"75.8937","type":"phone","created_at":"2023-09-14 10:45:17","user_type":null,"type_of_seller":"Manufacturers,Wholesaler","state":"21","country":"101","subscription_type":"1","otp":"672596","broucher":"650297216012f_5af4ed7d-0664-4ddb-8e38-74412fce39f3.jpg","media":null,"city_name":""}
/// seller_data_info : {"id":"5","user_id":"515","slug":null,"category_ids":null,"store_name":"Harish Shop","store_description":null,"logo":null,"store_url":null,"no_of_ratings":"0","rating":"0.00","bank_name":null,"bank_code":null,"account_name":null,"account_number":null,"national_identity_card":null,"address_proof":null,"authorized_signature":"","pan_number":null,"tax_name":null,"tax_number":"","permissions":null,"commission":"0.00","status":"1","date_added":"2023-09-14 10:46:17","udyog_num":"","partner":"","other_number":"7855888588","partner_number":"","company_address":"vijay nagar","facebook":"","instagram":"","web_link":"","linkedin":"","purchase_id":"","seller_category_id":"","partner_address":""}

class VendorData {
  VendorData({
    String? sellerId,
    ProductInfo? productInfo,
    SellerInfo? sellerInfo,
    SellerDataInfo? sellerDataInfo,
  }) {
    _sellerId = sellerId;
    _productInfo = productInfo;
    _sellerInfo = sellerInfo;
    _sellerDataInfo = sellerDataInfo;
  }

  VendorData.fromJson(dynamic json) {
    _sellerId = json['seller_id'];
    _productInfo = json['product_info'] != null
        ? ProductInfo.fromJson(json['product_info'])
        : null;
    _sellerInfo = json['seller_info'] != null
        ? SellerInfo.fromJson(json['seller_info'])
        : null;
    _sellerDataInfo = json['seller_data_info'] != null
        ? SellerDataInfo.fromJson(json['seller_data_info'])
        : null;
  }
  String? _sellerId;
  ProductInfo? _productInfo;
  SellerInfo? _sellerInfo;
  SellerDataInfo? _sellerDataInfo;
  VendorData copyWith({
    String? sellerId,
    ProductInfo? productInfo,
    SellerInfo? sellerInfo,
    SellerDataInfo? sellerDataInfo,
  }) =>
      VendorData(
        sellerId: sellerId ?? _sellerId,
        productInfo: productInfo ?? _productInfo,
        sellerInfo: sellerInfo ?? _sellerInfo,
        sellerDataInfo: sellerDataInfo ?? _sellerDataInfo,
      );
  String? get sellerId => _sellerId;
  ProductInfo? get productInfo => _productInfo;
  SellerInfo? get sellerInfo => _sellerInfo;
  SellerDataInfo? get sellerDataInfo => _sellerDataInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seller_id'] = _sellerId;
    if (_productInfo != null) {
      map['product_info'] = _productInfo?.toJson();
    }
    if (_sellerInfo != null) {
      map['seller_info'] = _sellerInfo?.toJson();
    }
    if (_sellerDataInfo != null) {
      map['seller_data_info'] = _sellerDataInfo?.toJson();
    }
    return map;
  }
}

/// id : "5"
/// user_id : "515"
/// slug : null
/// category_ids : null
/// store_name : "Harish Shop"
/// store_description : null
/// logo : null
/// store_url : null
/// no_of_ratings : "0"
/// rating : "0.00"
/// bank_name : null
/// bank_code : null
/// account_name : null
/// account_number : null
/// national_identity_card : null
/// address_proof : null
/// authorized_signature : ""
/// pan_number : null
/// tax_name : null
/// tax_number : ""
/// permissions : null
/// commission : "0.00"
/// status : "1"
/// date_added : "2023-09-14 10:46:17"
/// udyog_num : ""
/// partner : ""
/// other_number : "7855888588"
/// partner_number : ""
/// company_address : "vijay nagar"
/// facebook : ""
/// instagram : ""
/// web_link : ""
/// linkedin : ""
/// purchase_id : ""
/// seller_category_id : ""
/// partner_address : ""

class SellerDataInfo {
  SellerDataInfo(
      {String? id,
      String? userId,
      dynamic slug,
      dynamic categoryIds,
      String? storeName,
      dynamic storeDescription,
      dynamic logo,
      dynamic storeUrl,
      String? noOfRatings,
      String? rating,
      dynamic bankName,
      dynamic bankCode,
      dynamic accountName,
      dynamic accountNumber,
      dynamic nationalIdentityCard,
      dynamic addressProof,
      String? authorizedSignature,
      dynamic panNumber,
      dynamic taxName,
      String? taxNumber,
      dynamic permissions,
      String? commission,
      String? status,
      String? dateAdded,
      String? udyogNum,
      String? partner,
      String? otherNumber,
      String? partnerNumber,
      String? companyAddress,
      String? facebook,
      String? instagram,
      String? webLink,
      String? linkedin,
      String? purchaseId,
      String? sellerCategoryId,
      String? partnerAddress,
      String? city}) {
    _id = id;
    _userId = userId;
    _slug = slug;
    _categoryIds = categoryIds;
    _storeName = storeName;
    _storeDescription = storeDescription;
    _logo = logo;
    _storeUrl = storeUrl;
    _noOfRatings = noOfRatings;
    _rating = rating;
    _bankName = bankName;
    _bankCode = bankCode;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _nationalIdentityCard = nationalIdentityCard;
    _addressProof = addressProof;
    _authorizedSignature = authorizedSignature;
    _panNumber = panNumber;
    _taxName = taxName;
    _taxNumber = taxNumber;
    _permissions = permissions;
    _commission = commission;
    _status = status;
    _dateAdded = dateAdded;
    _udyogNum = udyogNum;
    _partner = partner;
    _otherNumber = otherNumber;
    _partnerNumber = partnerNumber;
    _companyAddress = companyAddress;
    _facebook = facebook;
    _instagram = instagram;
    _webLink = webLink;
    _linkedin = linkedin;
    _purchaseId = purchaseId;
    _sellerCategoryId = sellerCategoryId;
    _city = city;
    _partnerAddress = partnerAddress;
  }

  SellerDataInfo.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _slug = json['slug'];
    _categoryIds = json['category_ids'];
    _storeName = json['store_name'];
    _storeDescription = json['store_description'];
    _logo = json['logo'];
    _storeUrl = json['store_url'];
    _noOfRatings = json['no_of_ratings'];
    _rating = json['rating'];
    _bankName = json['bank_name'];
    _bankCode = json['bank_code'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _nationalIdentityCard = json['national_identity_card'];
    _addressProof = json['address_proof'];
    _authorizedSignature = json['authorized_signature'];
    _panNumber = json['pan_number'];
    _taxName = json['tax_name'];
    _taxNumber = json['tax_number'];
    _permissions = json['permissions'];
    _commission = json['commission'];
    _status = json['status'];
    _dateAdded = json['date_added'];
    _udyogNum = json['udyog_num'];
    _partner = json['partner'];
    _otherNumber = json['other_number'];
    _partnerNumber = json['partner_number'];
    _companyAddress = json['company_address'];
    _facebook = json['facebook'];
    _instagram = json['instagram'];
    _webLink = json['web_link'];
    _linkedin = json['linkedin'];
    _purchaseId = json['purchase_id'];
    _sellerCategoryId = json['seller_category_id'];
    _city = json['city'];
    _partnerAddress = json['partner_address'];
  }
  String? _id;
  String? _userId;
  dynamic _slug;
  dynamic _categoryIds;
  String? _storeName;
  dynamic _storeDescription;
  dynamic _logo;
  dynamic _storeUrl;
  String? _noOfRatings;
  String? _rating;
  dynamic _bankName;
  dynamic _bankCode;
  dynamic _accountName;
  dynamic _accountNumber;
  dynamic _nationalIdentityCard;
  dynamic _addressProof;
  String? _authorizedSignature;
  dynamic _panNumber;
  dynamic _taxName;
  String? _taxNumber;
  dynamic _permissions;
  String? _commission;
  String? _status;
  String? _dateAdded;
  String? _udyogNum;
  String? _partner;
  String? _otherNumber;
  String? _partnerNumber;
  String? _companyAddress;
  String? _facebook;
  String? _instagram;
  String? _webLink;
  String? _linkedin;
  String? _purchaseId;
  String? _sellerCategoryId;
  String? _city;
  String? _partnerAddress;
  SellerDataInfo copyWith({
    String? id,
    String? userId,
    dynamic slug,
    dynamic categoryIds,
    String? storeName,
    dynamic storeDescription,
    dynamic logo,
    dynamic storeUrl,
    String? noOfRatings,
    String? rating,
    dynamic bankName,
    dynamic bankCode,
    dynamic accountName,
    dynamic accountNumber,
    dynamic nationalIdentityCard,
    dynamic addressProof,
    String? authorizedSignature,
    dynamic panNumber,
    dynamic taxName,
    String? taxNumber,
    dynamic permissions,
    String? commission,
    String? status,
    String? dateAdded,
    String? udyogNum,
    String? partner,
    String? otherNumber,
    String? partnerNumber,
    String? companyAddress,
    String? facebook,
    String? instagram,
    String? webLink,
    String? linkedin,
    String? purchaseId,
    String? sellerCategoryId,
    String? partnerAddress,
    String? city,
  }) =>
      SellerDataInfo(
        id: id ?? _id,
        userId: userId ?? _userId,
        slug: slug ?? _slug,
        categoryIds: categoryIds ?? _categoryIds,
        storeName: storeName ?? _storeName,
        storeDescription: storeDescription ?? _storeDescription,
        logo: logo ?? _logo,
        storeUrl: storeUrl ?? _storeUrl,
        noOfRatings: noOfRatings ?? _noOfRatings,
        rating: rating ?? _rating,
        bankName: bankName ?? _bankName,
        bankCode: bankCode ?? _bankCode,
        accountName: accountName ?? _accountName,
        accountNumber: accountNumber ?? _accountNumber,
        nationalIdentityCard: nationalIdentityCard ?? _nationalIdentityCard,
        addressProof: addressProof ?? _addressProof,
        authorizedSignature: authorizedSignature ?? _authorizedSignature,
        panNumber: panNumber ?? _panNumber,
        taxName: taxName ?? _taxName,
        taxNumber: taxNumber ?? _taxNumber,
        permissions: permissions ?? _permissions,
        commission: commission ?? _commission,
        status: status ?? _status,
        dateAdded: dateAdded ?? _dateAdded,
        udyogNum: udyogNum ?? _udyogNum,
        partner: partner ?? _partner,
        otherNumber: otherNumber ?? _otherNumber,
        partnerNumber: partnerNumber ?? _partnerNumber,
        companyAddress: companyAddress ?? _companyAddress,
        facebook: facebook ?? _facebook,
        instagram: instagram ?? _instagram,
        webLink: webLink ?? _webLink,
        linkedin: linkedin ?? _linkedin,
        purchaseId: purchaseId ?? _purchaseId,
        sellerCategoryId: sellerCategoryId ?? _sellerCategoryId,
        city: city ?? _city,
        partnerAddress: partnerAddress ?? _partnerAddress,
      );
  String? get id => _id;
  String? get userId => _userId;
  dynamic get slug => _slug;
  dynamic get categoryIds => _categoryIds;
  String? get storeName => _storeName;
  dynamic get storeDescription => _storeDescription;
  dynamic get logo => _logo;
  dynamic get storeUrl => _storeUrl;
  String? get noOfRatings => _noOfRatings;
  String? get rating => _rating;
  dynamic get bankName => _bankName;
  dynamic get bankCode => _bankCode;
  dynamic get accountName => _accountName;
  dynamic get accountNumber => _accountNumber;
  dynamic get nationalIdentityCard => _nationalIdentityCard;
  dynamic get addressProof => _addressProof;
  String? get authorizedSignature => _authorizedSignature;
  dynamic get panNumber => _panNumber;
  dynamic get taxName => _taxName;
  String? get taxNumber => _taxNumber;
  dynamic get permissions => _permissions;
  String? get commission => _commission;
  String? get status => _status;
  String? get dateAdded => _dateAdded;
  String? get udyogNum => _udyogNum;
  String? get partner => _partner;
  String? get otherNumber => _otherNumber;
  String? get partnerNumber => _partnerNumber;
  String? get companyAddress => _companyAddress;
  String? get facebook => _facebook;
  String? get instagram => _instagram;
  String? get webLink => _webLink;
  String? get linkedin => _linkedin;
  String? get purchaseId => _purchaseId;
  String? get sellerCategoryId => _sellerCategoryId;
  String? get city => _city;

  String? get partnerAddress => _partnerAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['slug'] = _slug;
    map['category_ids'] = _categoryIds;
    map['store_name'] = _storeName;
    map['store_description'] = _storeDescription;
    map['logo'] = _logo;
    map['store_url'] = _storeUrl;
    map['no_of_ratings'] = _noOfRatings;
    map['rating'] = _rating;
    map['bank_name'] = _bankName;
    map['bank_code'] = _bankCode;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['national_identity_card'] = _nationalIdentityCard;
    map['address_proof'] = _addressProof;
    map['authorized_signature'] = _authorizedSignature;
    map['pan_number'] = _panNumber;
    map['tax_name'] = _taxName;
    map['tax_number'] = _taxNumber;
    map['permissions'] = _permissions;
    map['commission'] = _commission;
    map['status'] = _status;
    map['date_added'] = _dateAdded;
    map['udyog_num'] = _udyogNum;
    map['partner'] = _partner;
    map['other_number'] = _otherNumber;
    map['partner_number'] = _partnerNumber;
    map['company_address'] = _companyAddress;
    map['facebook'] = _facebook;
    map['instagram'] = _instagram;
    map['web_link'] = _webLink;
    map['linkedin'] = _linkedin;
    map['purchase_id'] = _purchaseId;
    map['seller_category_id'] = _sellerCategoryId;
    map['city'] = _city;
    map['partner_address'] = _partnerAddress;
    return map;
  }
}

/// id : "515"
/// ip_address : null
/// username : "Harish"
/// password : ""
/// normal_password : null
/// email : "harish@gmail.com"
/// mobile : "7855777747"
/// image : null
/// balance : "0"
/// activation_selector : null
/// activation_code : null
/// forgotten_password_selector : null
/// forgotten_password_code : null
/// forgotten_password_time : null
/// remember_selector : null
/// remember_code : null
/// created_on : "0"
/// last_login : "1697031824"
/// active : null
/// company : null
/// address : "Vijay Nagar, Indore, Madhya Pradesh 452010, India"
/// bonus_type : "percentage_per_order"
/// bonus : null
/// cash_received : "0.00"
/// dob : null
/// country_code : null
/// city : "Indore"
/// destrict : "indore"
/// area : "vijay nagar"
/// street : null
/// pincode : "452010"
/// serviceable_zipcodes : null
/// apikey : null
/// referral_code : null
/// friends_code : null
/// fcm_id : null
/// latitude : "22.7533"
/// longitude : "75.8937"
/// type : "phone"
/// created_at : "2023-09-14 10:45:17"
/// user_type : null
/// type_of_seller : "Manufacturers,Wholesaler"
/// state : "21"
/// country : "101"
/// subscription_type : "1"
/// otp : "672596"
/// broucher : "650297216012f_5af4ed7d-0664-4ddb-8e38-74412fce39f3.jpg"
/// media : null
/// city_name : ""

class SellerInfo {
  SellerInfo({
    String? id,
    dynamic ipAddress,
    String? username,
    String? password,
    dynamic normalPassword,
    String? email,
    String? mobile,
    dynamic image,
    String? balance,
    dynamic activationSelector,
    dynamic activationCode,
    dynamic forgottenPasswordSelector,
    dynamic forgottenPasswordCode,
    dynamic forgottenPasswordTime,
    dynamic rememberSelector,
    dynamic rememberCode,
    String? createdOn,
    String? lastLogin,
    dynamic active,
    dynamic company,
    String? address,
    String? bonusType,
    dynamic bonus,
    String? cashReceived,
    dynamic dob,
    dynamic countryCode,
    String? city,
    String? destrict,
    String? area,
    dynamic street,
    String? pincode,
    dynamic serviceableZipcodes,
    dynamic apikey,
    dynamic referralCode,
    dynamic friendsCode,
    dynamic fcmId,
    String? latitude,
    String? longitude,
    String? type,
    String? createdAt,
    dynamic userType,
    String? typeOfSeller,
    String? state,
    String? country,
    String? subscriptionType,
    String? otp,
    String? broucher,
    dynamic media,
    String? cityName,
  }) {
    _id = id;
    _ipAddress = ipAddress;
    _username = username;
    _password = password;
    _normalPassword = normalPassword;
    _email = email;
    _mobile = mobile;
    _image = image;
    _balance = balance;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _company = company;
    _address = address;
    _bonusType = bonusType;
    _bonus = bonus;
    _cashReceived = cashReceived;
    _dob = dob;
    _countryCode = countryCode;
    _city = city;
    _destrict = destrict;
    _area = area;
    _street = street;
    _pincode = pincode;
    _serviceableZipcodes = serviceableZipcodes;
    _apikey = apikey;
    _referralCode = referralCode;
    _friendsCode = friendsCode;
    _fcmId = fcmId;
    _latitude = latitude;
    _longitude = longitude;
    _type = type;
    _createdAt = createdAt;
    _userType = userType;
    _typeOfSeller = typeOfSeller;
    _state = state;
    _city = city;
    _country = country;
    _subscriptionType = subscriptionType;
    _otp = otp;
    _broucher = broucher;
    _media = media;
    _cityName = cityName;
  }

  SellerInfo.fromJson(dynamic json) {
    _id = json['id'];
    _ipAddress = json['ip_address'];
    _username = json['username'];
    _password = json['password'];
    _normalPassword = json['normal_password'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _balance = json['balance'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _city = json['city'];

    _company = json['company'];
    _address = json['address'];
    _bonusType = json['bonus_type'];
    _bonus = json['bonus'];
    _cashReceived = json['cash_received'];
    _dob = json['dob'];
    _countryCode = json['country_code'];
    _city = json['city'];
    _destrict = json['destrict'];
    _area = json['area'];
    _street = json['street'];
    _pincode = json['pincode'];
    _serviceableZipcodes = json['serviceable_zipcodes'];
    _apikey = json['apikey'];
    _referralCode = json['referral_code'];
    _friendsCode = json['friends_code'];
    _fcmId = json['fcm_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _userType = json['user_type'];
    _typeOfSeller = json['type_of_seller'];
    _state = json['state'];
    _country = json['country'];
    _subscriptionType = json['subscription_type'];
    _otp = json['otp'];
    _broucher = json['broucher'];
    _media = json['media'];
    _cityName = json['city_name'];
  }
  String? _id;
  dynamic _ipAddress;
  String? _username;
  String? _password;
  dynamic _normalPassword;
  String? _email;
  String? _mobile;
  dynamic _image;
  String? _balance;
  dynamic _activationSelector;
  dynamic _activationCode;
  dynamic _forgottenPasswordSelector;
  dynamic _forgottenPasswordCode;
  dynamic _forgottenPasswordTime;
  dynamic _rememberSelector;
  dynamic _rememberCode;
  String? _createdOn;
  String? _lastLogin;
  dynamic _active;
  dynamic _company;
  String? _address;
  String? _bonusType;
  String? _city;
  dynamic _bonus;
  String? _cashReceived;
  dynamic _dob;
  dynamic _countryCode;
  String? _destrict;
  String? _area;
  dynamic _street;
  String? _pincode;
  dynamic _serviceableZipcodes;
  dynamic _apikey;
  dynamic _referralCode;
  dynamic _friendsCode;
  dynamic _fcmId;
  String? _latitude;
  String? _longitude;
  String? _type;
  String? _createdAt;
  dynamic _userType;
  String? _typeOfSeller;
  String? _state;
  String? _country;
  String? _subscriptionType;
  String? _otp;
  String? _broucher;
  dynamic _media;
  String? _cityName;
  SellerInfo copyWith({
    String? id,
    dynamic ipAddress,
    String? username,
    String? password,
    dynamic normalPassword,
    String? email,
    String? mobile,
    dynamic image,
    String? balance,
    dynamic activationSelector,
    dynamic activationCode,
    dynamic forgottenPasswordSelector,
    dynamic forgottenPasswordCode,
    dynamic forgottenPasswordTime,
    dynamic rememberSelector,
    dynamic rememberCode,
    String? createdOn,
    String? lastLogin,
    dynamic active,
    dynamic company,
    String? address,
    String? bonusType,
    dynamic bonus,
    String? cashReceived,
    dynamic dob,
    dynamic countryCode,
    String? city,
    String? destrict,
    String? area,
    dynamic street,
    String? pincode,
    dynamic serviceableZipcodes,
    dynamic apikey,
    dynamic referralCode,
    dynamic friendsCode,
    dynamic fcmId,
    String? latitude,
    String? longitude,
    String? type,
    String? createdAt,
    dynamic userType,
    String? typeOfSeller,
    String? state,
    String? country,
    String? subscriptionType,
    String? otp,
    String? broucher,
    dynamic media,
    String? cityName,
  }) =>
      SellerInfo(
        id: id ?? _id,
        ipAddress: ipAddress ?? _ipAddress,
        username: username ?? _username,
        password: password ?? _password,
        normalPassword: normalPassword ?? _normalPassword,
        email: email ?? _email,
        mobile: mobile ?? _mobile,
        image: image ?? _image,
        balance: balance ?? _balance,
        activationSelector: activationSelector ?? _activationSelector,
        activationCode: activationCode ?? _activationCode,
        forgottenPasswordSelector:
            forgottenPasswordSelector ?? _forgottenPasswordSelector,
        forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
        forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
        rememberSelector: rememberSelector ?? _rememberSelector,
        rememberCode: rememberCode ?? _rememberCode,
        createdOn: createdOn ?? _createdOn,
        lastLogin: lastLogin ?? _lastLogin,
        active: active ?? _active,
        company: company ?? _company,
        address: address ?? _address,
        bonusType: bonusType ?? _bonusType,
        bonus: bonus ?? _bonus,
        cashReceived: cashReceived ?? _cashReceived,
        dob: dob ?? _dob,
        countryCode: countryCode ?? _countryCode,
        city: city ?? _city,
        destrict: destrict ?? _destrict,
        area: area ?? _area,
        street: street ?? _street,
        pincode: pincode ?? _pincode,
        serviceableZipcodes: serviceableZipcodes ?? _serviceableZipcodes,
        apikey: apikey ?? _apikey,
        referralCode: referralCode ?? _referralCode,
        friendsCode: friendsCode ?? _friendsCode,
        fcmId: fcmId ?? _fcmId,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        type: type ?? _type,
        createdAt: createdAt ?? _createdAt,
        userType: userType ?? _userType,
        typeOfSeller: typeOfSeller ?? _typeOfSeller,
        state: state ?? _state,
        country: country ?? _country,
        subscriptionType: subscriptionType ?? _subscriptionType,
        otp: otp ?? _otp,
        broucher: broucher ?? _broucher,
        media: media ?? _media,
        cityName: cityName ?? _cityName,
      );
  String? get id => _id;
  dynamic get ipAddress => _ipAddress;
  String? get username => _username;
  String? get password => _password;
  dynamic get normalPassword => _normalPassword;
  String? get email => _email;
  String? get mobile => _mobile;
  dynamic get image => _image;
  String? get balance => _balance;
  dynamic get activationSelector => _activationSelector;
  dynamic get activationCode => _activationCode;
  dynamic get forgottenPasswordSelector => _forgottenPasswordSelector;
  dynamic get forgottenPasswordCode => _forgottenPasswordCode;
  dynamic get forgottenPasswordTime => _forgottenPasswordTime;
  dynamic get rememberSelector => _rememberSelector;
  dynamic get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  String? get lastLogin => _lastLogin;
  dynamic get active => _active;
  dynamic get company => _company;
  String? get address => _address;
  String? get bonusType => _bonusType;
  dynamic get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  dynamic get dob => _dob;
  dynamic get countryCode => _countryCode;
  String? get city => _city;
  String? get destrict => _destrict;
  String? get area => _area;
  dynamic get street => _street;
  String? get pincode => _pincode;
  dynamic get serviceableZipcodes => _serviceableZipcodes;
  dynamic get apikey => _apikey;
  dynamic get referralCode => _referralCode;
  dynamic get friendsCode => _friendsCode;
  dynamic get fcmId => _fcmId;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get type => _type;
  String? get createdAt => _createdAt;
  dynamic get userType => _userType;
  String? get typeOfSeller => _typeOfSeller;
  String? get state => _state;
  String? get country => _country;
  String? get subscriptionType => _subscriptionType;
  String? get otp => _otp;
  String? get broucher => _broucher;
  dynamic get media => _media;
  String? get cityName => _cityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ip_address'] = _ipAddress;
    map['username'] = _username;
    map['password'] = _password;
    map['normal_password'] = _normalPassword;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['balance'] = _balance;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['company'] = _company;
    map['address'] = _address;
    map['bonus_type'] = _bonusType;
    map['bonus'] = _bonus;
    map['cash_received'] = _cashReceived;
    map['dob'] = _dob;
    map['country_code'] = _countryCode;
    map['city'] = _city;
    map['destrict'] = _destrict;
    map['area'] = _area;
    map['street'] = _street;
    map['pincode'] = _pincode;
    map['serviceable_zipcodes'] = _serviceableZipcodes;
    map['apikey'] = _apikey;
    map['referral_code'] = _referralCode;
    map['friends_code'] = _friendsCode;
    map['fcm_id'] = _fcmId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['user_type'] = _userType;
    map['type_of_seller'] = _typeOfSeller;
    map['state'] = _state;
    map['country'] = _country;
    map['subscription_type'] = _subscriptionType;
    map['otp'] = _otp;
    map['broucher'] = _broucher;
    map['media'] = _media;
    map['city_name'] = _cityName;
    return map;
  }
}

/// id : "1"
/// product_identity : null
/// category_id : "4"
/// seller_id : "511"
/// tax : "0"
/// row_order : "0"
/// type : "simple_product"
/// stock_type : null
/// name : "Plastic Cap"
/// short_description : "Plastic dana"
/// slug : "plastic-cap-1"
/// indicator : "0"
/// cod_allowed : "0"
/// download_allowed : "0"
/// download_type : ""
/// download_link : ""
/// minimum_order_quantity : "1"
/// quantity_step_size : "1"
/// total_allowed_quantity : null
/// is_prices_inclusive_tax : "0"
/// is_returnable : "0"
/// is_cancelable : "0"
/// cancelable_till : ""
/// image : "uploads/media/2023/download_-_2023-09-13T122345_629.jpg"
/// other_images : "[]"
/// broucher_image : "uploads/media/2023/WhatsApp_Image_2023-08-01_at_16_07_104.jpeg"
/// video_type : ""
/// video : ""
/// tags : "plastic"
/// warranty_period : ""
/// guarantee_period : ""
/// made_in : null
/// hsn_code : ""
/// brand : null
/// sku : null
/// stock : null
/// availability : null
/// rating : "4"
/// no_of_ratings : "1"
/// description : "<p>plastic dana</p>"
/// extra_description : "<p>plastic dana</p>"
/// deliverable_type : "1"
/// deliverable_zipcodes : null
/// pickup_location : " "
/// status : "1"
/// date_added : "2023-09-13 12:41:20"
/// sub_cat_id : "5"
/// attribute_title : "Material Type, Colour, Weight"
/// attribute_value : "Plastic, Multipul, 100 KG"
class ProductInfo {
  String? id;
  dynamic productIdentity;
  String? categoryId;
  String? sellerId;
  String? tax;
  String? rowOrder;
  String? type;
  dynamic stockType;
  String? name;
  String? shortDescription;
  String? slug;
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
  String? image;
  List<String>? otherImages;
  List<String>? broucherImage;
  String? videoType;
  String? video;
  String? tags;
  String? warrantyPeriod;
  String? guaranteePeriod;
  String? madeIn;
  String? hsnCode;
  String? brand;
  dynamic sku;
  dynamic stock;
  dynamic availability;
  String? rating;
  String? noOfRatings;
  String? description;
  String? extraDescription;
  String? deliverableType;
  dynamic deliverableZipcodes;
  String? pickupLocation;
  String? status;
  String? dateAdded;
  String? subCatId;
  String? attributeTitle;
  String? attributeValue;

  ProductInfo({
    this.id,
    this.productIdentity,
    this.categoryId,
    this.sellerId,
    this.tax,
    this.rowOrder,
    this.type,
    this.stockType,
    this.name,
    this.shortDescription,
    this.slug,
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
    this.image,
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
    this.sku,
    this.stock,
    this.availability,
    this.rating,
    this.noOfRatings,
    this.description,
    this.extraDescription,
    this.deliverableType,
    this.deliverableZipcodes,
    this.pickupLocation,
    this.status,
    this.dateAdded,
    this.subCatId,
    this.attributeTitle,
    this.attributeValue,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["id"],
        productIdentity: json["product_identity"],
        categoryId: json["category_id"],
        sellerId: json["seller_id"],
        tax: json["tax"],
        rowOrder: json["row_order"],
        type: json["type"],
        stockType: json["stock_type"],
        name: json["name"],
        shortDescription: json["short_description"],
        slug: json["slug"],
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
        image: json["image"],
        otherImages: json["other_images"] == null
            ? []
            : List<String>.from(json["other_images"]!.map((x) => x)),
        broucherImage: json["broucher_image"] == null
            ? []
            : List<String>.from(json["broucher_image"]!.map((x) => x)),
        videoType: json["video_type"],
        video: json["video"],
        tags: json["tags"],
        warrantyPeriod: json["warranty_period"],
        guaranteePeriod: json["guarantee_period"],
        madeIn: json["made_in"],
        hsnCode: json["hsn_code"],
        brand: json["brand"],
        sku: json["sku"],
        stock: json["stock"],
        availability: json["availability"],
        rating: json["rating"],
        noOfRatings: json["no_of_ratings"],
        description: json["description"],
        extraDescription: json["extra_description"],
        deliverableType: json["deliverable_type"],
        deliverableZipcodes: json["deliverable_zipcodes"],
        pickupLocation: json["pickup_location"],
        status: json["status"],
        dateAdded: json["date_added"],
        subCatId: json["sub_cat_id"],
        attributeTitle: json["attribute_title"],
        attributeValue: json["attribute_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_identity": productIdentity,
        "category_id": categoryId,
        "seller_id": sellerId,
        "tax": tax,
        "row_order": rowOrder,
        "type": type,
        "stock_type": stockType,
        "name": name,
        "short_description": shortDescription,
        "slug": slug,
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
        "image": image,
        "other_images": otherImages == null
            ? []
            : List<dynamic>.from(otherImages!.map((x) => x)),
        "broucher_image": broucherImage == null
            ? []
            : List<dynamic>.from(broucherImage!.map((x) => x)),
        "video_type": videoType,
        "video": video,
        "tags": tags,
        "warranty_period": warrantyPeriod,
        "guarantee_period": guaranteePeriod,
        "made_in": madeIn,
        "hsn_code": hsnCode,
        "brand": brand,
        "sku": sku,
        "stock": stock,
        "availability": availability,
        "rating": rating,
        "no_of_ratings": noOfRatings,
        "description": description,
        "extra_description": extraDescription,
        "deliverable_type": deliverableType,
        "deliverable_zipcodes": deliverableZipcodes,
        "pickup_location": pickupLocation,
        "status": status,
        "date_added": dateAdded,
        "sub_cat_id": subCatId,
        "attribute_title": attributeTitle,
        "attribute_value": attributeValue,
      };
}
