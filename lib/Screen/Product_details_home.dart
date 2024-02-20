import 'dart:convert';
import 'dart:developer';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/Screen/MapHomeScreen.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api.path.dart';
import '../Model/Get_home_product_details_model.dart';
import '../color.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';

class ProductDetailsHome extends StatefulWidget {
  String? pId, businessName, sellerId;
  ProductDetailsHome({Key? key, this.pId, this.businessName, this.sellerId})
      : super(key: key);

  @override
  State<ProductDetailsHome> createState() => _ProductDetailsHomeState();
}

class _ProductDetailsHomeState extends State<ProductDetailsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    getProductDetailsApi();
  }

  Future<void> openMap(String latitude, String longitude) async {
    String googleUrl = "";
    if (latitude == "" || latitude == "null") {
      googleUrl =
          'https://www.google.com/maps/search/?api=1&query=${getHomeProductDetails!.data?.first.address.toString()} ${getHomeProductDetails?.data?.first.city} ${getHomeProductDetails?.data?.first.stateName} ${getHomeProductDetails?.data?.first.pincode}';
    } else {
      googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    }

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  String? mNo;
  getProfile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sessionId = sharedPreferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    if (sessionId == null) {
      yourMobileNumber.text = "";
    } else {
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
        mNo = "${profileStore2['data']['mobile'] ?? ""}";
        yourMobileNumber.text = mNo ?? "";
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(text: "Product Detail", isTrue: false, context: context),
      body: getHomeProductDetails == null || getHomeProductDetails == ""
          ? const Center(child: CircularProgressIndicator())
          : getHomeProductDetails!.data!.length == 0
              ? const Center(child: Text("No Details Found!!"))
              : Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final imageProvider = Image.network(
                                      getHomeProductDetails?.data.first.image ??
                                          "")
                                  .image;
                              showImageViewer(context, imageProvider,
                                  onViewerDismissed: () {
                                print("dismissed");
                              });
                            },
                            child: Container(
                                height: 250,
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: getHomeProductDetails
                                                    ?.data?.first.image ==
                                                null ||
                                            getHomeProductDetails
                                                    ?.data?.first.image ==
                                                " "
                                        ? Image.asset(
                                            "Images/no-image-icon.png",
                                            height: 200,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          )
                                        : InteractiveViewer(
                                            child: Image.network(
                                            "${getHomeProductDetails?.data?.first.image}",
                                            fit: BoxFit.fill,
                                          )))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "${getHomeProductDetails?.data?.first.storeName}",
                                style: const TextStyle(
                                    color: colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width: 110,
                                  child: Text(
                                    "(${widget.businessName})",
                                    style: const TextStyle(
                                      color: colors.black,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${getHomeProductDetails?.data?.first.name}",
                            style: const TextStyle(
                                color: colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(),
                          Row(
                            children: [
                              RatingBar.builder(
                                itemSize: 20,
                                initialRating: double.parse(
                                    getHomeProductDetails
                                            ?.data?.first.sellerRating ??
                                        "0"),
                                minRating: 0,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Text(
                                  "${getHomeProductDetails?.data?.first.sellerRating} (Reviews)"),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                              height: 40,
                              child: Row(
                                children: [
                                  const Text("Tags :",
                                      style: TextStyle(
                                          color: colors.black,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  getHomeProductDetails?.data![0].tags == null
                                      ? const SizedBox.shrink()
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: colors.primary
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 25,
                                          width: 140,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: getHomeProductDetails
                                                  ?.data![0].tags!.length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                      "${getHomeProductDetails?.data![0].tags!.join(',')}"),
                                                );
                                              }),
                                        ),
                                ],
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "Short Description: ",
                            style: TextStyle(
                                color: colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Html(
                              data: getHomeProductDetails
                                  ?.data.first.shortDescription),
                          // Text(
                          //     "${getHomeProductDetails?.data.first.shortDescription}"),
                          const SizedBox(height: 5),
                          const Text(
                            "Description: ",
                            style: TextStyle(
                                color: colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Html(
                              data: getHomeProductDetails
                                  ?.data.first.description),

                          const SizedBox(height: 5),
                          const Text(
                            "Extra Description: ",
                            style: TextStyle(
                                color: colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Html(
                              data: getHomeProductDetails
                                  ?.data.first.extraDescription),

                          const SizedBox(height: 5),
                          getHomeProductDetails?.data.first.attributeTitle == ""
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TableWidget(
                                    dataList: getHomeProductDetails
                                            ?.data.first.attributeTitle ??
                                        "",
                                    dataListValue: getHomeProductDetails
                                            ?.data.first.attributeValue ??
                                        "",
                                  ),
                                ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Address: ",
                            style: TextStyle(
                                color: colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${getHomeProductDetails?.data.first.address}"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${getHomeProductDetails?.data.first.city},",
                          ),
                          Text("${getHomeProductDetails?.data.first.pincode},"),
                          Text(
                              "${getHomeProductDetails?.data.first.destrict},"),
                          Text(
                              "${getHomeProductDetails?.data.first.stateName}"),
                          const Text("India"),
                          const SizedBox(height: 10),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 95),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            openMap(
                                                getHomeProductDetails?.data
                                                        .first.latitude! ??
                                                    "",
                                                getHomeProductDetails?.data
                                                        .first.longitude! ??
                                                    "");
                                          },
                                          child: const CircleAvatar(
                                            radius: 15,
                                            backgroundColor: colors.secondary,
                                            child: Icon(
                                              Icons.location_pin,
                                              size: 15,
                                              color: colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        Image.asset(
                                          "Images/phone.png",
                                          scale: 2,
                                          color: getHomeProductDetails
                                                      ?.data.first.tax_number ==
                                                  ""
                                              ? colors.primary
                                              : colors.secondary,
                                        ),
                                        const SizedBox(width: 7),
                                        Image.asset("Images/person.png",
                                            scale: 2),
                                        const SizedBox(width: 7),
                                        Image.asset("Images/register.png",
                                            scale: 2),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 0, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              border: Border.all(
                                                  width: 2, color: Colors.grey),
                                              color: colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          'Broucher Image'),
                                                      content: getHomeProductDetails
                                                                  ?.data
                                                                  .first
                                                                  .broucherImage ==
                                                              null
                                                          ? Image.asset(
                                                              "Images/no-image-icon.png",
                                                              height: 120,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : Image.network(
                                                              "${getHomeProductDetails?.data.first.broucherImage}"),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: getHomeProductDetails
                                                                  ?.data
                                                                  .first
                                                                  .tax_number ==
                                                              ""
                                                          ? colors.primary
                                                          : colors.secondary),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Icon(
                                                      Icons.description,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    color: getHomeProductDetails
                                                                ?.data
                                                                .first
                                                                .subscription_type ==
                                                            1
                                                        ? colors.primary
                                                        : colors.secondary),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 3,
                                                      bottom: 3),
                                                  child: Icon(
                                                    Icons.check_circle_outline,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    color: getHomeProductDetails
                                                                ?.data
                                                                .first
                                                                .subscription_type ==
                                                            1
                                                        ? colors.primary
                                                        : colors.secondary),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 3,
                                                      bottom: 3),
                                                  child: Icon(
                                                    Icons.verified_user,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final Uri url = Uri.parse(
                                                      getHomeProductDetails
                                                              ?.data
                                                              .first
                                                              .web_link ??
                                                          "");
                                                  if (!await launchUrl(url)) {
                                                    throw Exception(
                                                        'Could not launch $url');
                                                  }
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: colors.primary),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Icon(
                                                      Icons.link,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final Uri url = Uri.parse(
                                                      getHomeProductDetails
                                                              ?.data
                                                              .first
                                                              .facebook ??
                                                          "");
                                                  if (!await launchUrl(url)) {
                                                    throw Exception(
                                                        'Could not launch $url');
                                                  }
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: colors.primary),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Icon(
                                                      Icons.facebook,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final Uri url = Uri.parse(
                                                      getHomeProductDetails
                                                              ?.data
                                                              .first
                                                              .instagram ??
                                                          "");
                                                  if (!await launchUrl(url)) {
                                                    throw Exception(
                                                        'Could not launch $url');
                                                  }
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: colors.primary),
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 3,
                                                          bottom: 3),
                                                      child: Image.asset(
                                                        "Images/instagram.png",
                                                        color: Colors.white,
                                                      )
                                                      // Icon(
                                                      //   Icons.verified_user,size: 15,
                                                      //   color: Colors.white,
                                                      // ),
                                                      ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final Uri url = Uri.parse(
                                                      getHomeProductDetails
                                                              ?.data
                                                              .first
                                                              .linkedin ??
                                                          "");
                                                  if (!await launchUrl(url)) {
                                                    throw Exception(
                                                        'Could not launch $url');
                                                  }
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50)),
                                                          color:
                                                              colors.primary),
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 3,
                                                          bottom: 3),
                                                      child: Image.asset(
                                                        "Images/linkedin.png",
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    child: Btn(
                                      height: 40,
                                      width: 150,
                                      title: "Contact Supplier",
                                      onPress: () {
                                        showDialogContactSuplier(
                                            getHomeProductDetails
                                                    ?.data.first.id ??
                                                "",
                                            mobilee);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  TextEditingController pinCodeController = new TextEditingController();
  final _Cotact = GlobalKey<FormState>();
  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController yourMobileNumber = TextEditingController();
  TextEditingController YourcityController = TextEditingController();
  bool verifie = false;
  String? controller;
  String? OTPIS;

  void showDialogContactSuplier(String productId, Mobile) async {
    print('______sasdsd____${productId}_________');
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
                            children: const [
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      maxLength: 10,
                                      // readOnly: true,
                                      controller: yourMobileNumber,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: Icon(
                                            Icons.call,
                                            color: colors.primary,
                                            size: 20,
                                          ),
                                        ),
                                        counterText: "",
                                        contentPadding: const EdgeInsets.only(
                                            top: 0, left: 0),
                                        hintText: "Your Mobile",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "mobile cannot be empty";
                                        } else if (val.length < 10) {
                                          return "Please enter 10 digit number";
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      controller: yournamecontroller,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        hintText: "Your Name",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Name cannot be empty";
                                        } else if (val.length < 3) {
                                          return "Please enter 3 digit Name";
                                        }
                                      },
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      maxLength: 10,

                                      //    readOnly: true,
                                      controller: yourMobileNumber,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        hintText: "Your Mobile",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "mobile cannot be empty";
                                        } else if (val.length < 10) {
                                          return "Please enter 10 digit number";
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      controller: YourcityController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        hintText: "Your City",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "City cannot be empty";
                                        } else if (val.length < 3) {
                                          return "Please enter 3 digit City";
                                        }
                                      },
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Btn(
                          height: 40,
                          width: 150,
                          title: "Send OTP",
                          onPress: () {
                            if (_Cotact.currentState!.validate()) {
                              sendOtpCotactSuplier(productId);
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

  sendOtpCotactSuplier(String ProductId) async {
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
        showDialogverifyContactSuplier(ProductId);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void showDialogverifyContactSuplier(String productIddd) async {
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
                          children: const [
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
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'OTP : $OTPIS',
                            style: const TextStyle(
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
                          const SizedBox(
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
                            sendEnqury(productIddd);
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

  Future<void> sendEnqury(String productid) async {
    var headers = {
      'Cookie': 'ci_session=ff1e2af38a215d1057b062b8ff903fc27b0c488b'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}save_inquiry'));

    if (userId == null || userId == '' || userId == 'null') {
      request.fields.addAll({
        'name': yournamecontroller.text.toString(),
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'product_id': productid.toString()
      });
    } else {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'product_id': productid.toString(),
        'user_id': userId.toString(),
      });
    }
    print('____sassasadad______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        Fluttertoast.showToast(msg: finalResult['message']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const B2BHome()));
      } else {
        Fluttertoast.showToast(msg: finalResult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  GetHomeProductDetailsModel? getHomeProductDetails;
  getProductDetailsApi() async {
    var headers = {
      'Cookie': 'ci_session=7b70d852d78e7fa54dfcb9f70964683c6b672974'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}get_products'));
    request.fields
        .addAll({'id': widget.pId ?? "", 'seller_id': widget.sellerId ?? ""});
    print('____this is a parameter______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetHomeProductDetailsModel.fromJson(jsonDecode(result));
      setState(() {
        getHomeProductDetails = finalResult;
      });
      log('____Aaa______${result}_________');
    } else {
      print(response.reasonPhrase);
    }
  }
}

class TableWidget extends StatelessWidget {
  final String dataList;
  final String dataListValue;

  const TableWidget(
      {super.key, required this.dataList, required this.dataListValue});
  @override
  Widget build(BuildContext context) {
    print(dataList);
    print(dataListValue);
    List<String> stringList = dataList.split(', ');
    List<String> stringList2 = dataListValue.split(', ');
    return Column(
      children: [
        // Table(
        //   border: TableBorder.all(color: Colors.black),
        //   children: [
        //     const TableRow(children: [
        //       Padding(
        //         padding: EdgeInsets.all(4.0),
        //         child: Center(
        //             child: Text(
        //           'Attribute',
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //         )),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.all(4.0),
        //         child: Center(
        //             child: Text(
        //           'Value',
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //         )),
        //       ),
        //     ]),
        //   ],
        // ),
        ListView.builder(
          itemCount: stringList.length,
          shrinkWrap: true, // Number of rows
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(0.0),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(child: Text(stringList[index])),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(child: Text(stringList2[index])),
                    ),
                  ])
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
