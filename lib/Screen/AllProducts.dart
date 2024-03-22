import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Api.path.dart';
import '../Model/AdModel.dart';
import '../Model/AllProductModel.dart';
import '../Model/CitySearchModel.dart';
import '../Model/businessCategoruModel.dart';
import '../apiServices/apiConstants.dart';
import '../apiServices/apiStrings.dart';
import '../color.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';
import '../widgets/categoryCard.dart';
import 'HomeScreen.dart';
import 'Product_details_home.dart';

class AllProduct extends StatefulWidget {
  AllProduct({Key? key, this.catName, this.catId, this.isTrue, this.catIdSpeci})
      : super(key: key);
  final String? catId, catIdSpeci;
  final String? catName;
  bool? isTrue;

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  void initState() {
    super.initState();
    print(widget.catId.toString() + "CAT ID");
    callApis();
    //yourMobileNumber.text =  mobilee;
  }

  callApis() async {
    getUserId();

    await businessCategory();
    await getAdvertisgment();
    await getAllProducts();
    await getProfile();
  }

  String? selectedBusiness;
  int? selectedBusinessIndex;
  String? businessId;
  String? businessName;

  //List<Data> productDataList = [];

  bool isLoading = false;

  // Future<void> getAllProducts() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var param = {"category_id":widget.isTrue ?? false? widget.catIdSpeci: widget.catId,"buisness_category":businessName == null ? "": businessName};
  //   apiBaseHelper.postAPICall(fetchProductByFillters, param).then((getData) {
  //     bool error = getData['error'];
  //     String msg = getData['message'];
  //     if (!error) {
  //       print('_____sass_____${getData}____${param}_____');
  //       var finalJson = AllProductModel.fromJson(getData);
  //       productDataList = finalJson.data ?? [];
  //       print('____new______${productDataList.first.name}_________');
  //       setState(() {
  //         isLoading = false;
  //       });
  //     } else {
  //       //Fluttertoast.showToast(msg: msg);
  //     }
  //   });
  // }

  getAdvertisgment() async {
    var headers = {'Cookie': 'PHPSESSID=vhk30ft0rihdb8lu81k71ps1hs'};
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiService.advertiesgment));
    request.fields.addAll({
      'category_id': widget.catId ?? "",
    });
    print("catrtrt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var store = await response.stream.bytesToString();
      adImages = AdModel.fromJson(json.decode(store));
    } else {
      print(response.reasonPhrase);
    }
  }

  AllProductModel? allProductModel;
  getAllProducts() async {
    var headers = {
      'Cookie': 'ci_session=e0263e969d813b65a1be63495b9454dffd37ea56'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}fetch_product_by_fillters'));
    request.fields.addAll({
      'category_id':
          selectedCategoryId == "" ? widget.catId ?? "" : selectedCategoryId,
      'city': searchController.text ?? "",
      if (businessName != 'Select All')
        'buisness_category': businessName == null ? "" : "${businessName}",
      "sub_cat_id": selectedCategoryId
    });
    print('____ddddd______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result.toString() + "PRODUUCTS");

      var finalResult = AllProductModel.fromJson(json.decode(result));
      setState(() {
        allProductModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String currentItem = "Relavance";
  String currentbusiness = "Manufacturers";
  List<String> items = [
    "Relavance",
    "Top Rated",
    "Newest First",
    "Oldest First",
    "Price - Low to High",
    "Price - High to Low"
  ];

  List<String> bussinessCat = [
    "Manufacturers",
    "Wholesaler",
    "Retailers",
    "Service Provider",
    "Vegetable Business",
    "Stationary Bussiness",
    "Stainless steel Business",
    "Farmer Comapny"
  ];

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController numberCtr = TextEditingController();
  TextEditingController cityCtr = TextEditingController();
  TextEditingController otpCtr = TextEditingController();
  TextEditingController numCtr = TextEditingController();

  bool verifie = false;
  var OTPIS;

  void getUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var idd = sharedPreferences.getString('id');

    setState(() {
      userId = idd.toString();

      print('user id in home page==========${userId}');
      print('user id in home page==========${userId.runtimeType}');
    });
  }

  Future<void> sendEnqury(String productid, String sellerId) async {
    var headers = {
      'Cookie': 'ci_session=ff1e2af38a215d1057b062b8ff903fc27b0c488b'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}save_inquiry'));
    if (userId == null || userId == '' || userId == 'null') {
      request.fields.addAll({
        'mobile': nameCtr.text.toString(),
        'city': cityCtr.text.toString(),
        'name': nameCtr.text.toString(),
        'product_id': productid.toString(),
        'sup_type': "Client",
        'seller_id': sellerId ?? "",
      });
    } else {
      request.fields.addAll({
        'mobile': nameCtr.text.toString(),
        'product_id': productid.toString(),
        'user_id': userId.toString(),
        'sup_type': "Client",
        'seller_id': sellerId ?? "",
        'city': city2
      });
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        Fluttertoast.showToast(msg: finalResult['message']);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: finalResult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? mNo;
  getProfile() async {
    print('__________this is a user id_________');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sessionId = sharedPreferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({'user_id': '${sessionId}'});
    print('____sss______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result2 = await response.stream.bytesToString();
      var profileStore = jsonDecode(result2);
      setState(() {
        profileStore2 = profileStore;
      });
    }
    if (profileStore2['error'] == false) {
      mNo = "${profileStore2['data']['mobile']}";

      print('______mobilee____${mNo}_________');
      yourMobileNumber.text = mNo ?? "";
    } else {
      print(response.reasonPhrase);
    }
  }

  List<City> cityList = [];
  String cityName = '';
  CitySearchModel? citySearchModel;

  TextEditingController searchController = TextEditingController();

  Future<List<String>> searchCityApi({String? filter}) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://suggest.imimg.com/suggest/suggest.php?q=$filter&tag=suggestions&limit=40&type=city&fields=state%2Cid%2Cstateid%2Cflname%2Calias&display_fields=value%2C%3Dstate&display_separator=%2C%20&match=fuzzy&catid=0&mcatid=0&v=398'));
    request.body = '''''';
    // print('__________${}_________');
    http.StreamedResponse response = await request.send();
    List<String> list = [];
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = CitySearchModel.fromJson(json.decode(result));
      setState(() {
        cityList = finalResult.city!;
        // cityList.insert(0, City(value: 'Select All City'));
        cityList.forEach((element) {
          list.add(element.value ?? '');
        });
      });
      return list;
    } else {
      print(response.reasonPhrase);
      return list;
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          searchController.text = "";
                          getAllProducts();
                          Navigator.pop(context);
                        },
                        child: const Text("Clear Filter"))),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    searchCityApi(filter: value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: cityList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cityList[index].value!),
                        onTap: () {
                          // Do something when suggestion is tapped
                          print('Selected suggestion: ${cityList[index]}');
                          searchController.text = cityList[index].value!;
                          getAllProducts();
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  String selectedCategoryId = "";

  String selectedCategory = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(text: "All Product", isTrue: false, context: context),
      body: allProductModel == null
          ? const Center(
              child: CircularProgressIndicator(
                color: colors.primary,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        _showBottomSheet();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                    color: colors.black.withOpacity(0.2))
                                // border:,
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Center(
                                  child: Row(
                                children: [
                                  Icon(Icons.location_city),
                                  const SizedBox(width: 4),
                                  Text(searchController.text == ""
                                      ? "Select City"
                                      : searchController.text),
                                ],
                              )),
                            ),
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Sort By :",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                        color: colors.black.withOpacity(0.2))
                                    // border:,
                                    ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    // onTap: () {
                                    //   // getSubCategory();
                                    // },

                                    // decoration: InputDecoration(
                                    //     contentPadding: EdgeInsets.only(
                                    //         bottom: 13.5, left: 20),
                                    //     border: InputBorder.none
                                    // ),
                                    value: currentItem,
                                    // underline: Container(),
                                    isExpanded: true,
                                    // icon: const Icon(
                                    //     Icons.keyboard_arrow_down),
                                    hint: Text(
                                      "Relevance",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 10),
                                    ),
                                    items: [
                                      "Relavance",
                                      "Top Rated",
                                      "Newest First",
                                      "Oldest First",
                                      "Price - Low to High",
                                      "Price - High to Low"
                                    ]
                                        .map<DropdownMenuItem<String>>(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? value) => setState(
                                      () {
                                        if (value != null) currentItem = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Business Categories :",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Container(
                              //   width: MediaQuery.of(context).size.width /
                              //       2.3,
                              //   height: 35,
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius:BorderRadius.all(Radius.circular(4)),
                              //       border: Border.all(
                              //           color: colors.black.withOpacity(0.2)
                              //       )
                              //   ),
                              //   child: DropdownButtonHideUnderline(
                              //     child: DropdownButtonFormField<String>(
                              //       onTap: () {
                              //         // getSubCategory();
                              //       },
                              //       decoration:InputDecoration(
                              //           contentPadding: EdgeInsets.only(
                              //               bottom: 13.5, left: 20),
                              //           border: InputBorder.none
                              //       ),
                              //
                              //       value:currentbusiness,
                              //       // underline: Container(),
                              //       isExpanded: true,
                              //       icon: const Icon(
                              //           Icons.keyboard_arrow_down),
                              //       hint: Text(
                              //         "Relevance",
                              //         style: TextStyle(
                              //             color: Colors.grey[400],
                              //             fontSize: 13),
                              //       ),
                              //       items:["Manufacturers", "Wholesaler", "Retailers", "Service Provider","Vegetable Business","Stationary Bussiness","Stainless steel Business","Farmer Comapny"]
                              //           .map<DropdownMenuItem<String>>(
                              //             (e) => DropdownMenuItem(
                              //           value: e,
                              //           child: Text(e),
                              //         ),
                              //       )
                              //           .toList(),
                              //       onChanged: (String? value) => setState(
                              //             () {
                              //           if (value != null) currentbusiness = value;
                              //         },
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: colors.black.withOpacity(0.2))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      "Select All",
                                      style: TextStyle(
                                          color: colors.black, fontSize: 10),
                                    ),
                                    value: selectedBusiness,
                                    underline: Container(
                                      width: 10,
                                      color: colors.white,
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedBusiness = value!;
                                        businesscatorymodel!.data!
                                            .forEach((element) {
                                          if (element.name == value) {
                                            selectedBusinessIndex =
                                                businesscatorymodel!.data!
                                                    .indexOf(element);
                                            businessId = element.id;
                                            businessName = element.name;
                                            getAllProducts();
                                            setState(() {});
                                          }
                                        });
                                      });
                                    },
                                    items:
                                        businesscatorymodel?.data?.map((items) {
                                      return DropdownMenuItem(
                                        value: items.name.toString(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: Text(
                                            items.name.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: colors.black),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  selectedCategory == ""
                      ? Container()
                      : Card(
                          color: const Color.fromARGB(255, 192, 219, 255),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(selectedCategory),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        selectedCategoryId = "";
                                        selectedCategory = "";
                                        getAllProducts();
                                        setState(() {});
                                      },
                                      child: const Icon(Icons.cancel)),
                                )
                              ],
                            ),
                          ),
                        ),
                  allProductModel == null
                      ? Container()
                      : SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: allProductModel!.subcategories!.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                var item =
                                    allProductModel!.subcategories![index];
                                return InkWell(
                                  onTap: () {
                                    selectedCategoryId = item.id!;
                                    selectedCategory = item.name!;
                                    getAllProducts();
                                    setState(() {});
                                  },
                                  child: Card(
                                      color: selectedCategoryId == item.id!
                                          ? const Color.fromARGB(
                                              255, 192, 219, 255)
                                          : null,
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Row(
                                          children: [
                                            Text(item.name!),
                                            selectedCategoryId == item.id!
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          selectedCategoryId =
                                                              "";
                                                          getAllProducts();
                                                          setState(() {});
                                                        },
                                                        child: const Icon(
                                                            Icons.cancel)),
                                                  )
                                                : Container()
                                          ],
                                        )),
                                      )),
                                );
                              }),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  carosalSlider(),
                  const SizedBox(
                    height: 5,
                  ),
                  allProductModel == null
                      ? Container()
                      : Container(
                          // alignment: Alignment.center,
                          child: allProductModel!.data!.isEmpty
                              ? const Center(child: Text("No Product Found!!"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: allProductModel!.data!.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var item = allProductModel!.data![index];
                                    return Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      margin: const EdgeInsets.all(0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailsHome(
                                                        pId: allProductModel!
                                                            .data![index].id,
                                                        sellerId:
                                                            allProductModel!
                                                                .data![index]
                                                                .sellerId,
                                                        businessName: item
                                                            .typeOfseller
                                                            ?.split(',')
                                                            .first,
                                                      )));
                                        },
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5.2,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    "${item.image}" ?? '',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 24, top: 10),
                                                child: Text(
                                                  "${item.name}" ?? '',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 24, top: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                              backgroundColor:
                                                                  colors
                                                                      .primary,
                                                              radius: 10,
                                                              child: Icon(
                                                                Icons
                                                                    .person_rounded,
                                                                color: colors
                                                                    .white,
                                                                size: 15,
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "${item.storeName}" ??
                                                                  ''),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              width: 120,
                                                              child: businessName ==
                                                                          null ||
                                                                      businessName ==
                                                                          "Select All"
                                                                  ? Text(
                                                                      "(${item.typeOfseller?.split(',').first ?? 'N/A'})" ??
                                                                          '',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "(${businessName})" ??
                                                                          '',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ))
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 24, top: 5),
                                                child: Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          colors.primary,
                                                      child: Icon(
                                                        Icons.location_pin,
                                                        size: 15,
                                                        color: colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                        width: 180,
                                                        child: Text(
                                                          "${item.sellerAddress}" ??
                                                              "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20,
                                                    top: 5,
                                                    right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          launchUrl(
                                                              Uri.parse(
                                                                  item.video ??
                                                                      ""),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .video_camera_back_outlined,
                                                              color: colors
                                                                  .primary,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text("Watch Video")
                                                          ],
                                                        )),
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Icon(
                                                              Icons.image,
                                                              color: colors
                                                                  .primary,
                                                            )),
                                                        InkWell(
                                                            onTap: () {
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                  title: Text(
                                                                      'Broucher Image'),
                                                                  content: Image
                                                                      .network(
                                                                          "${item.broucherImage}"),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                                "Broucher"))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50)),
                                                          color: Colors
                                                              .deepPurple),
                                                      child: Icon(
                                                        Icons.add_circle,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Colors
                                                              .deepPurple),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 3,
                                                                bottom: 3),
                                                        child: Icon(
                                                          Icons.message,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          color:
                                                              colors.secondary),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 3,
                                                                bottom: 3),
                                                        child: Icon(
                                                          Icons.mail_outline,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50)),
                                                          color:
                                                              colors.primary),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 3,
                                                                bottom: 3),
                                                        child: Icon(
                                                          Icons.location_pin,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              20,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          border: Border.all(
                                                              width: 2,
                                                              color:
                                                                  Colors.grey),
                                                          color: colors.white),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                                color: item.taxNumber ==
                                                                        ""
                                                                    ? colors
                                                                        .primary
                                                                    : colors
                                                                        .secondary),
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 3,
                                                                      bottom:
                                                                          3),
                                                              child: Icon(
                                                                Icons
                                                                    .description,
                                                                size: 15,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                                color: item.subscriptionType ==
                                                                        1
                                                                    ? colors
                                                                        .primary
                                                                    : colors
                                                                        .secondary),
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 3,
                                                                      bottom:
                                                                          3),
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle_outline,
                                                                size: 15,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                                color: item.subscriptionType ==
                                                                        1
                                                                    ? colors
                                                                        .primary
                                                                    : colors
                                                                        .secondary),
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 3,
                                                                      bottom:
                                                                          3),
                                                              child: Icon(
                                                                Icons
                                                                    .verified_user,
                                                                size: 15,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Btn(
                                                  onPress: () {
                                                    showDialogContactSuplier(
                                                        item.id ?? "",
                                                        item.sellerId ?? "");
                                                  },
                                                  height: 40,
                                                  width: 150,
                                                  title: "Contact Supplier",
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                    // productsCard(
                                    //     businessName: businesscatorymodel?.data?[0].name,
                                    //     context: context,
                                    //     image: item.image,
                                    //     storeName: item.storeName,
                                    //     sub: item.subscriptionType,
                                    //     textName: item.taxNumber,
                                    //     productName: item.name,
                                    //     address: item.sellerAddress,
                                    //     title: "Contact Supplier",
                                    //     onTap: () async {
                                    //       final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                    //       String? obtainedOtp = sharedPreferences.getString('id');
                                    //       String?  obtainedMobile = sharedPreferences.getString('mobile');
                                    //       if(obtainedOtp==''|| obtainedOtp==null){
                                    //
                                    //         _showDialog(context);
                                    //       }else{
                                    //         numCtr.text=obtainedMobile!;
                                    //         _showDialog2(context);
                                    //       }
                                    //     });
                                  }),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
    );
  }

  BusinessCategoruModel? businesscatorymodel;

  Future<void> businessCategory() async {
    apiBaseHelper.getAPICall(getBusinessCategory).then((getData) {
      bool error = getData['error'];
      if (!error) {
        businesscatorymodel = BusinessCategoruModel.fromJson(getData);
        businesscatorymodel?.data
            ?.insert(0, SellerTypeData(name: 'Select All'));
      } else {}
    });
  }

  TextEditingController pinCodeController = new TextEditingController();
  final _Cotact = GlobalKey<FormState>();
  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController yourMobileNumber = TextEditingController();
  TextEditingController YourcityController = TextEditingController();
  String? controller;
  sendOtpCotactSuplier(String ProductId, String sellerId) async {
    print('xcvbjkl;k');

    var headers = {
      'Cookie': 'ci_session=aa35b4867a14620a4c973d897c5ae4ec6c25ee8e'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}send_otp_for_enquiry'));

    if (userId == null || userId == '' || userId == 'null') {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'name': yournamecontroller.text.toString(),
      });
    } else {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
      });
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['error'] == false) {
        setState(() {
          verifie = true;
          OTPIS = finalresult['data']['otp'].toString();
        });
        Navigator.pop(context);
        showDialogverifyContactSuplier(ProductId, sellerId);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  Widget carosalSlider() {
    return adImages!.data.isEmpty
        ? Container()
        : Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 1.0,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: CarouselSlider(
              items: adImages?.data
                  .map(
                    (item) => GestureDetector(
                      onTap: () {
                        final imageProvider = Image.network(
                                ApiService.adbaseUrl + item.name ?? "")
                            .image;
                        showImageViewer(context, imageProvider,
                            onViewerDismissed: () {
                          print("dismissed");
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            ApiService.adbaseUrl + item.name,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 1,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          );
  }

  void showDialogContactSuplier(String productId, String sellerId) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId == "null" ? 400 : 250,
                width: MediaQuery.of(context).size.width / 1.2,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Form(
                    key: _Cotact,
                    child: Column(
                      children: [
                        Container(
                          color: colors.primary,
                          height: 60,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Contact Supplier',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        userId != 'null'
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      maxLength: 10,
                                      controller: yourMobileNumber,
                                      decoration: new InputDecoration(
                                        prefixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Icon(
                                            Icons.call,
                                            color: colors.primary,
                                            size: 20,
                                          ),
                                        ),
                                        counterText: "",
                                        contentPadding:
                                            EdgeInsets.only(top: 0, left: 0),
                                        hintText: "Your Mobile",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Mobile Number';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      controller: yournamecontroller,
                                      decoration: new InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 5, left: 5),
                                        hintText: "Your Name",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Name';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      maxLength: 10,
                                      readOnly: true,
                                      controller: yourMobileNumber,
                                      decoration: new InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 5, left: 5),
                                        hintText: "Your Mobile",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Mobile Number';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      controller: YourcityController,
                                      decoration: new InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 5, left: 5),
                                        hintText: "Your City",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter City';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Btn(
                          height: 40,
                          width: 150,
                          title: "Send OTP",
                          onPress: () {
                            if (_Cotact.currentState!.validate()) {
                              sendOtpCotactSuplier(productId, sellerId);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void showDialogverifyContactSuplier(
      String productIddd, String sellerId) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 250,
                width: MediaQuery.of(context).size.width / 1.5,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        color: colors.primary,
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Contact Supplier',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'OTP : ${OTPIS}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: OtpTextField(
                              numberOfFields: 4,
                              fieldWidth: 20,
                              borderColor: Colors.red,
                              focusedBorderColor: Colors.blue,
                              showFieldAsBox: false,
                              borderWidth: 1,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                print(code);
                                // pinCodeController.text=code;
                                //  controller=code;
                                //handle validation or checks here if necessary
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                controller = verificationCode;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Btn(
                        height: 40,
                        width: 150,
                        title: "Verify OTP",
                        onPress: () {
                          if (controller == OTPIS) {
                            sendEnqury(productIddd, sellerId);
                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
