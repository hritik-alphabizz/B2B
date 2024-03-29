import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:b2b/AuthView/login.dart';
import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api.path.dart';
import '../Model/Get_home_product_details_model.dart';
import '../Model/ratingsModel.dart';
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
    getProductReviewApi();
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

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

  List<String> images = [];
  var userId = "";
  String? mNo;
  getProfile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sessionId = sharedPreferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    userId = sessionId ?? "";
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
        namee = profileStore2['data']['username'].toString();
        yournamecontroller.text = namee;

        city2 = "${profileStore2['data']['city']}";
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
                              final imageProvider =
                                  Image.network(images[currentIndex] ?? "")
                                      .image;
                              showImageViewer(context, imageProvider,
                                  onViewerDismissed: () {
                                print("dismissed");
                              });
                            },
                            child: Container(
                                height: 200,
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
                                      : CarouselSlider(
                                          items: images
                                              .map(
                                                (item) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: InteractiveViewer(
                                                      child: Image.network(
                                                        item,
                                                        fit: BoxFit.fill,
                                                        width: double.infinity,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          carouselController:
                                              carouselController,
                                          options: CarouselOptions(
                                            scrollPhysics:
                                                const BouncingScrollPhysics(),
                                            autoPlay: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 500),
                                            aspectRatio: 2,
                                            viewportFraction: 1,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                          ),
                                        ),

                                  //  InteractiveViewer(
                                  //     child: Image.network(
                                  //     "${getHomeProductDetails?.data?.first.image}",
                                  //     fit: BoxFit.fill,
                                  //   )
                                  //   )
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: AnimatedSmoothIndicator(
                                activeIndex: currentIndex,
                                count: images.length ?? 0,
                                effect: const SlideEffect(
                                  spacing: 5.6,
                                  radius: 10.0,
                                  dotWidth: 7.0,
                                  dotHeight: 7.0,
                                  dotColor: Color.fromRGBO(246, 137, 133, 0.5),
                                  activeDotColor: colors.primary,
                                ),
                              ),
                            ),
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
                                          // decoration: BoxDecoration(
                                          //     color: colors.primary
                                          //         .withOpacity(0.4),
                                          //     borderRadius:
                                          //         BorderRadius.circular(5)),
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: getHomeProductDetails
                                                  ?.data![0].tags!.length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: colors.primary
                                                            .withOpacity(0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Text(
                                                          getHomeProductDetails
                                                                  ?.data![0]
                                                                  .tags![i]!
                                                                  .toString()
                                                                  .replaceAll(
                                                                      "[", "")
                                                                  .replaceAll(
                                                                      "]",
                                                                      "") ??
                                                              ""
                                                          //  "${getHomeProductDetails?.data![0].tags!.join(',')}"
                                                          ),
                                                    ),
                                                  ),
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
                                  ?.data!.first.shortDescription),
                          // Text(
                          //     "${getHomeProductDetails?.data!.first.shortDescription}"),
                          const SizedBox(height: 5),

                          getHomeProductDetails?.data!.first.videoType ==
                                  "youtube"
                              ? GestureDetector(
                                  onTap: () {
                                    launchUrl(
                                        Uri.parse(getHomeProductDetails
                                                ?.data!.first.video ??
                                            ""),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Watch Video: ",
                                        style: TextStyle(
                                            color: colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.videocam, color: Colors.red),
                                    ],
                                  ),
                                )
                              : Container(),
                          getHomeProductDetails?.data!.first.videoType ==
                                  "youtube"
                              ? const SizedBox(height: 5)
                              : Container(),

                          Container(
                            margin: const EdgeInsets.only(left: 0, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      color: colors.white),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final Uri url = Uri.parse(
                                              getHomeProductDetails
                                                      ?.data!.first.webLink ??
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
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
                                                      ?.data!.first.facebook ??
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
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
                                                      ?.data!.first.instagram ??
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
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
                                                      ?.data!.first.linkedin ??
                                                  "");
                                          if (!await launchUrl(url)) {
                                            throw Exception(
                                                'Could not launch $url');
                                          }
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              color: colors.primary),
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
                          const Text(
                            "Description: ",
                            style: TextStyle(
                                color: colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Html(
                              data: getHomeProductDetails
                                  ?.data!.first.description),

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
                                  ?.data!.first.extraDescription),

                          const SizedBox(height: 5),
                          getHomeProductDetails?.data!.first.attributeTitle ==
                                  ""
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TableWidget(
                                    dataList: getHomeProductDetails
                                            ?.data!.first.attributeTitle ??
                                        "",
                                    dataListValue: getHomeProductDetails
                                            ?.data!.first.attributeValue ??
                                        "",
                                  ),
                                ),
                          // const SizedBox(
                          //   height: 8,
                          // ),

                          const Text(
                            "Address: ",
                            style: TextStyle(
                                color: colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${getHomeProductDetails?.data!.first.address}"),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${getHomeProductDetails?.data!.first.city},",
                          ),
                          Text(
                              "${getHomeProductDetails?.data!.first.pincode},"),
                          Text(
                              "${getHomeProductDetails?.data!.first.destrict},"),
                          Text(
                              "${getHomeProductDetails?.data!.first.stateName}"),
                          const Text("India"),
                          const SizedBox(height: 10),

                          userId != null
                              ? ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blueAccent)),
                                  onPressed: () {
                                    showRatingDialog();
                                  },
                                  child: Text(
                                    "Add Review",
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      userId == null
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage(),
                                                    ));
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    color: Colors.deepPurple),
                                                child: const Icon(
                                                  Icons.add_circle,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                openMap(
                                                    getHomeProductDetails?.data!
                                                            .first.latitude! ??
                                                        "",
                                                    getHomeProductDetails?.data!
                                                            .first.longitude! ??
                                                        "");
                                              },
                                              child: const CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    colors.secondary,
                                                child: Icon(
                                                  Icons.location_pin,
                                                  size: 15,
                                                  color: colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                                onTap: () {
                                                  // launchUrl(
                                                  //     Uri.parse("tel:" +
                                                  //         (getHomeProductDetails
                                                  //                 ?.data!
                                                  //                 .first
                                                  //                 .mobile ??
                                                  //             "")),
                                                  //     mode: LaunchMode
                                                  //         .externalApplication);
                                                },
                                                child: Image.asset(
                                                  "Images/Group 81121.png",
                                                  height: 25,
                                                )),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                                onTap: () {
                                                  // launchUrl(
                                                  //     Uri.parse("sms:" +
                                                  //         (getHomeProductDetails
                                                  //                 ?.data!
                                                  //                 .first
                                                  //                 .mobile ??
                                                  //             "")),
                                                  //     mode: LaunchMode
                                                  //         .externalApplication);
                                                },
                                                child: Image.asset(
                                                  "Images/Group 81119.png",
                                                  height: 25,
                                                )),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                                onTap: () {
                                                  launchUrl(
                                                      Uri.parse("mailto:" +
                                                          (getHomeProductDetails
                                                                  ?.data!
                                                                  .first
                                                                  .email ??
                                                              "")),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                },
                                                child: Image.asset(
                                                  "Images/Group 81117.png",
                                                  height: 25,
                                                ))
                                            //  Icon(
                                            //     Icons.mail,
                                            //     color: colors
                                            //         .primary)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                23,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
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
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(50)),
                                                  color:
                                                      // getHomeProductDetails
                                                      //             ?.data!
                                                      //             .first
                                                      //             .active ==
                                                      //         ""
                                                      //     ? Colors.red
                                                      //     :
                                                      colors.secondary),
                                              child: Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Icon(Icons.person,
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(50)),
                                                  color: getHomeProductDetails
                                                              ?.data!
                                                              .first
                                                              .taxNumber ==
                                                          ""
                                                      ? colors.primary
                                                      : colors.secondary),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Image.asset(
                                                  "Images/phone.png",
                                                  scale: 2,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(50)),
                                                  color: getHomeProductDetails
                                                              ?.data!
                                                              .first
                                                              .subscriptionType !=
                                                          "1"
                                                      ? Colors.red
                                                      : colors.secondary),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 3,
                                                    bottom: 3),
                                                child: Image.asset(
                                                    "Images/person.png",
                                                    color: Colors.white,
                                                    scale: 2),
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Btn(
                                      height: 40,
                                      width: 150,
                                      title: "Contact Supplier",
                                      onPress: () {
                                        showDialogContactSuplier(
                                            getHomeProductDetails
                                                    ?.data!.first.id ??
                                                "",
                                            mobilee,
                                            getHomeProductDetails
                                                    ?.data!.first.sellerId ??
                                                "");
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          ratingsModel!.data!.isEmpty
                              ? Container()
                              : const Text(
                                  "Reviews: ",
                                  style: TextStyle(
                                      color: colors.black,
                                      fontWeight: FontWeight.bold),
                                ),

                          SizedBox(
                            height: ratingsModel!.data!.length * 150,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ratingsModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final review = ratingsModel!.data![index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 214, 213, 213)),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: CircleAvatar(
                                                radius: 25,
                                                child: Icon(
                                                    Icons
                                                        .account_circle_rounded,
                                                    size: 25),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        review.userName! + " (",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Icon(Icons.star,
                                                          size: 20,
                                                          color: Colors.yellow),
                                                      Text(
                                                        review.rating! + ")",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(review.comment ?? ""),
                                                  SizedBox(height: 8),
                                                  review.images!.isEmpty
                                                      ? Container()
                                                      : GestureDetector(
                                                          onTap: () {
                                                            final imageProvider =
                                                                Image.network(review
                                                                            .images!
                                                                            .first ??
                                                                        "")
                                                                    .image;
                                                            showImageViewer(
                                                                context,
                                                                imageProvider,
                                                                onViewerDismissed:
                                                                    () {
                                                              print(
                                                                  "dismissed");
                                                            });
                                                          },
                                                          child: Image.network(
                                                            review.images!
                                                                    .first ??
                                                                "",
                                                            height: 45,
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: userId ==
                                            ratingsModel!.data![index].userId
                                                .toString(),
                                        child: InkWell(
                                          onTap: () {
                                            // Fluttertoast.showToast(
                                            //     msg: ratingsModel!
                                            //         .data![index].id!
                                            //         .toString());
                                            _showDeleteReviewDialog(
                                                context,
                                                ratingsModel!.data![index].id!
                                                    .toString());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(Icons.delete)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );

                                // ListTile(
                                //   title: Text(review.comment ?? ""),
                                //   subtitle: Text('${review.userName}'),
                                //   leading: CircleAvatar(
                                //     child: Text(review.rating!),
                                //     backgroundColor: Colors.blue,
                                //     foregroundColor: Colors.white,
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  void _showDeleteReviewDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Review'),
          content: Text('Are you sure you want to delete your review?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var headers = {
                  'Cookie': 'PHPSESSID=f5kvmvsbf3f8fe8dltfd34h2nk'
                };
                // Add code to delete the review here
                var request = http.MultipartRequest(
                    'POST',
                    Uri.parse(
                        'https://b2bdiary.com/seller/app/v1/api/delete_product_rating'));
                request.fields.addAll({'rating_id': id});

                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  print(await response.stream.bytesToString());
                  Fluttertoast.showToast(msg: "Rating Deleted Successfully");
                } else {
                  print(response.reasonPhrase);
                }
                getProductReviewApi();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
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
  double _rating = 0;
  File? selectedFile;
  TextEditingController _commentController = TextEditingController();

  Future<void> showRatingDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Write a Review'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Comment',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 2),
                  selectedFile == null
                      ? GestureDetector(
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                            setState(() {});
                          },
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Select Image"),
                                  ))),
                        )
                      : InkWell(
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                            setState(() {});
                          },
                          child: Image.file(
                            selectedFile!,
                            height: 100,
                          ),
                        )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Here you can handle the submission of the review
                    print('Rating: $_rating');
                    print('Comment: ${_commentController.text}');
                    //Navigator.of(context).pop();
                    // Close the dialog
                    addMediaReview();
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          });
        });
  }

  addMediaReview() async {
    var headers = {
      'Cookie': 'ci_session=132520c09b577cf52b95da927b9b0491da5d3bda'
    };
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sessionId = sharedPreferences.getString('id');
    print("heree");

    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}set_product_rating'));
    request.fields.addAll({
      'user_id': sessionId!,
      'product_id': widget.pId.toString(),
      'rating': _rating.toString(),
      'comment': _commentController.text
    });
    if (selectedFile == null) {
    } else {
      request.files.add(
          await http.MultipartFile.fromPath('images[]', selectedFile!.path));
    }

    print(request.fields.toString());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      print(finalResult.toString());
      Fluttertoast.showToast(msg: finalResult["message"]);
      Navigator.pop(context, true);
      getProductReviewApi();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedFile = File(pickedFile.path);
      });
      Navigator.pop(context);
      showRatingDialog();
    }
  }

  void showDialogContactSuplier(
      String productId, Mobile, String sellerId) async {
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

  sendOtpCotactSuplier(String ProductId, String sellerId) async {
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

  Future<void> sendEnqury(String productid, String sellerId) async {
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
        'product_id': productid.toString(),
        'sup_type': "Client",
        'seller_id': sellerId ?? "",
      });
    } else {
      request.fields.addAll({
        'name': yournamecontroller.text.toString(),
        'mobile': yourMobileNumber.text.toString(),
        'product_id': productid.toString(),
        'user_id': userId.toString(),
        'sup_type': "Client",
        'seller_id': sellerId ?? "",
        'city': city2
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
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: finalResult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  GetHomeProductDetailsModel? getHomeProductDetails;
  RatingsModel? ratingsModel;
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
        if (getHomeProductDetails!.data![0].image!.isNotEmpty) {
          images.add(getHomeProductDetails!.data![0].image!);
          images.addAll(getHomeProductDetails!.data![0].otherImages!);
        }
      });
      log('____Aaa______${result}_________');
    } else {
      print(response.reasonPhrase);
    }
  }

  getProductReviewApi() async {
    var headers = {
      'Cookie': 'ci_session=7b70d852d78e7fa54dfcb9f70964683c6b672974'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}get_product_rating'));
    request.fields.addAll({
      'product_id': widget.pId ?? "",
    });
    print('____this is a parameter_ ratings_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = ratingsModelFromJson(result);
      setState(() {
        ratingsModel = finalResult;
      });
      log('____Aaa_ result review_____${result}_________');
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
