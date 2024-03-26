import 'dart:convert';
import 'package:b2b/AuthView/login.dart';
import 'package:b2b/Model/temp_model.dart';
import 'package:b2b/Screen/AllProducts.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/apiServices/apiStrings.dart';
import 'package:b2b/color.dart';
import 'package:b2b/utils/GetPreference.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api.path.dart';
import '../Model/Get_all_cat_model.dart';
import '../Model/Get_suppplier_or_client_model.dart';
import '../Model/SupplierCatModel.dart';
import '../Model/suplier_Client_supplier_response.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';
import 'HomeScreen.dart';
import 'package:http/http.dart' as http;

import 'MapScreen.dart';
import 'Product_details_home.dart';

class SupplierScreen extends StatefulWidget {
  String? isManu;
  bool? nameChange;

  SupplierScreen({Key? key, this.nameChange, this.isManu}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    businessCategory();
    getSupplier("");
    homeCategories();
    getProfile();
    // selectedBusiness=widget.isManu.toString();
    mobilee = yourMobileNumber.text;
  }

  var profileStore2;

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
      print("get profile parameter ${request.fields}");
      print(
          "sign up details para ${request.fields}==========================================================");
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result2 = await response.stream.bytesToString();
        var profileStore = jsonDecode(result2);
        setState(() {
          profileStore2 = profileStore;
          print(result2.toString());
          namee = profileStore2['data']['username'].toString();
          yournamecontroller.text = namee;

          city2 = "${profileStore2['data']['city']}";

          // print("${store2}");
        });
      }
      if (profileStore2['error'] == false) {
        mobilee = "${profileStore2['data']['mobile']}";
        yourMobileNumber.text = mobilee ?? "";
        print('______sssss____${mobilee}_________');
      } else {
        print(response.reasonPhrase);
      }
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

  String? selectedBusiness;
  String? selectedCity;
  int? selectedBusinessIndex;
  String? businessId;
  var businessName;

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contact Supplier ',
            style: TextStyle(fontSize: 15, color: colors.primary),
          ),
          actions: [
            Container(
              // height: 500,
              child: Form(
                key: _formKey1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: nameCtr,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your Name',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.person_rounded),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: numberCtr,
                        cursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your Mobile',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.call),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: cityCtr,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your City',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.location_city),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          if (nameCtr.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please enter the name.");
                          } else if (numberCtr.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please enter the mobile number.");
                          } else if (cityCtr.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please enter the city.");
                          } else {
                            otpCtr.text = "";
                            _showDialogOTP(context);
                          }
                        },
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _showDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contact Supplier ',
            style: TextStyle(fontSize: 15, color: colors.primary),
          ),
          actions: [
            Container(
              // height: 500,
              child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: numCtr,
                        cursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your Mobile',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.call),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          otpCtr.text = "";
                          _showDialogOTP(context);
                        },
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  _showDialogOTP(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contact Supplier ',
            style: TextStyle(fontSize: 15, color: colors.primary),
          ),
          actions: [
            Container(
              // height: 500,
              child: Form(
                key: _formKey3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: otpCtr,
                        cursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'OTP',
                          hintStyle: TextStyle(color: Colors.black26),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          if (otpCtr.text == "") {
                            Fluttertoast.showToast(msg: "Please enter OTP.");
                          } else {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>B2BHome()));
                          }
                        },
                        child: const Text(
                          'Verify OTP',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<HomeCatListAll> cateList = [];
  GetAllCatModel? homeCategory;

  homeCategories() async {
    var headers = {
      'Cookie': 'ci_session=a0c4a8147cd6ca589ca5ea95dd55a72e8678d0d2'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getAllCategories}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetAllCatModel.fromJson(json.decode(finalResponse));
      homeCategory = jsonResponse;
      cateList = homeCategory?.data ?? [];
      setState(() {
        homeCategory = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  SupplierCatModel? businesscatorymodel;

  Future<void> businessCategory() async {
    apiBaseHelper.getAPICall(getSupplierCategoryApi).then((getData) {
      bool error = getData['error'];
      if (!error) {
        businesscatorymodel = SupplierCatModel.fromJson(getData);
        // businesscatorymodel?.data?.add(BussinessData(name: "Select All"));
      } else {}
    });
  }

  furspit(data) {
    final splitted = data.split(',');
    print(splitted);
    return splitted[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          text: widget.nameChange == true ? "Products List" : "Your Suppliers",
          isTrue: false,
          context: context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: colors.primary),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                                      fontSize: 12,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
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
                                      hint: const Text(
                                        "Relevance",
                                        style: TextStyle(
                                            color: colors.black, fontSize: 12),
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
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: colors.black),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? value) => setState(
                                        () {
                                          if (value != null)
                                            currentItem = value;
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
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Business Categories :",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color:
                                              colors.black.withOpacity(0.4))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      //value: selectedBusiness[0],
                                      isExpanded: true,

                                      hint: const Text(
                                        "Categories",
                                        style: TextStyle(
                                            color: colors.black, fontSize: 10),
                                      ),
                                      // dropdownColor: colors.primary,
                                      value: selectedBusiness,
                                      // icon: const Padding(
                                      //   padding: EdgeInsets.only(right:10.0),
                                      //   child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 10,),
                                      // ),
                                      // style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
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
                                              print("devi$businessName");
                                              setState(() {
                                                // widget.isManu = "";
                                              });
                                              getSupplier(selectedCity == "All"
                                                  ? ""
                                                  : selectedCity ?? "");
                                            }
                                          });
                                        });
                                      },
                                      items: businesscatorymodel?.data
                                          ?.map((items) {
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "City",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color:
                                              colors.black.withOpacity(0.4))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      //value: selectedBusiness[0],
                                      isExpanded: true,

                                      hint: const Text(
                                        "Cities",
                                        style: TextStyle(
                                            color: colors.black, fontSize: 10),
                                      ),
                                      // dropdownColor: colors.primary,
                                      value: selectedCity,
                                      // icon: const Padding(
                                      //   padding: EdgeInsets.only(right:10.0),
                                      //   child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 10,),
                                      // ),
                                      // style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                                      underline: Container(
                                        width: 10,
                                        color: colors.white,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedCity = value!;
                                        });
                                        getSupplier(selectedCity == "All"
                                            ? ""
                                            : selectedCity ?? "");
                                        //  searchProduct(value ?? '');
                                      },
                                      items: cityList.map((items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: Text(
                                              capitalizeFirstLetter(items),
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
                    Visibility(
                      visible: tempList.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Gogglemap(
                                              tempMode2: valueList,
                                            )));
                              },
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: colors.primary,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.location_on_outlined,
                                    color: colors.white,
                                  )))),
                        ),
                      ),
                    ),
                    getSubcat(),
                  ],
                ),
              ),
            ),
    );
  }

  getSubcat() {
    return valueList.isEmpty
        ? const Center(child: Text("Product Not Found!!"))
        : Container(
            padding: const EdgeInsets.only(top: 0, right: 5),
            child: ListView.builder(
              itemCount: valueList.length,
              // scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                if (i == null) {
                  return Container();
                } else {
                  return
                      // valueList.isEmpty ? Center(child: Text("No Product Found!!")):

                      Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllProduct(
                                        catId: valueList[i]
                                            .temp!
                                            .first
                                            .categoryId
                                            .toString())));
                          },
                          child: Container(
                            //  padding:
                            // / EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "${valueList[i].catName}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.9,
                          //  GetSub!.data![i].products!.length >3? 280:140,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              itemCount: valueList[i].temp!.length,
                              //> 6 ? 6 : GetSub!.data![i].products!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsHome(
                                                  pId: valueList[i]
                                                      .temp![index]
                                                      .id,
                                                  businessName:
                                                      "${valueList[i].temp![index].typeOfSeller?.split(',').first}" ??
                                                          '',
                                                )));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    margin: const EdgeInsets.all(0),
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5.6,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                "${valueList[i].temp![index].image}" ??
                                                    '',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 24, top: 10),
                                            child: Text(
                                              "${valueList[i].temp![index].name}" ??
                                                  '',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                                      const CircleAvatar(
                                                          backgroundColor:
                                                              colors.primary,
                                                          radius: 10,
                                                          child: Icon(
                                                            Icons
                                                                .person_rounded,
                                                            color: colors.white,
                                                            size: 15,
                                                          )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.32,
                                                        child: Text(
                                                          "${valueList[i].temp![index].storeName}" ??
                                                              '',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: 120,
                                                          child: widget
                                                                      .isManu ==
                                                                  null
                                                              ? businessName ==
                                                                          null ||
                                                                      businessName ==
                                                                          "Select All"
                                                                  ? Text(
                                                                      "(${valueList[i].temp![index].typeOfSeller?.split(',').first})" ??
                                                                          '',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      "($businessName)",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                              : businessName ==
                                                                      null
                                                                  ? Text(
                                                                      "(${widget.isManu})" ??
                                                                          '',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : businessName ==
                                                                          "Select All"
                                                                      ? Text(
                                                                          "(${valueList[i].temp![index].typeOfSeller?.split(',').first})" ??
                                                                              '',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              color: colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      : Text(
                                                                          "(${businessName})",
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              color: colors.black,
                                                                              fontWeight: FontWeight.bold),
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
                                                      "${valueList[i].temp![index].sellerAddress}" ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, top: 5, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      launchUrl(
                                                          Uri.parse(
                                                              "${valueList[i].temp![index].video}" ??
                                                                  ""),
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .video_camera_back_outlined,
                                                          color: colors.primary,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const InkWell(
                                                            child: Text(
                                                                "Watch Video"))
                                                      ],
                                                    )),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (valueList[i]
                                                        .temp![index]
                                                        .broucherImage!
                                                        .isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Broucher image is empty");
                                                    }
                                                    List<ImageProvider<Object>>
                                                        imageProviders = [];

                                                    for (int i = 0;
                                                        i <
                                                            valueList[i]
                                                                .temp![index]
                                                                .broucherImage!
                                                                .length;
                                                        i++) {
                                                      imageProviders.add(
                                                          NetworkImage(valueList[
                                                                  i]
                                                              .temp![index]
                                                              .broucherImage![i]
                                                              .toString()));
                                                    }

                                                    MultiImageProvider
                                                        multiImageProvider =
                                                        MultiImageProvider(
                                                            imageProviders);
                                                    showImageViewerPager(
                                                        context,
                                                        multiImageProvider,
                                                        doubleTapZoomable: true,
                                                        onPageChanged: (page) {
                                                      print(
                                                          "page changed to $page");
                                                    }, onViewerDismissed:
                                                            (page) {
                                                      print(
                                                          "dismissed while on page $page");
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const CircleAvatar(
                                                          radius: 15,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Icon(
                                                            Icons.image,
                                                            color:
                                                                colors.primary,
                                                          )),
                                                      const Text("Broucher")
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
                                            margin: const EdgeInsets.only(
                                                left: 15, right: 15),
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
                                                                builder:
                                                                    (context) =>
                                                                        const LoginPage(),
                                                              ));
                                                        },
                                                        child: Container(
                                                          height: 25,
                                                          width: 25,
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          50)),
                                                              color: Colors
                                                                  .deepPurple),
                                                          child: const Icon(
                                                            Icons.add_circle,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox.shrink(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // openMap(
                                                          //     getHomeProductDetails
                                                          //             ?.data
                                                          //             .first
                                                          //             .latitude! ??
                                                          //         "",
                                                          //     getHomeProductDetails
                                                          //             ?.data
                                                          //             .first
                                                          //             .longitude! ??
                                                          //         "");
                                                        },
                                                        child:
                                                            const CircleAvatar(
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
                                                      const SizedBox(width: 4),
                                                      GestureDetector(
                                                          onTap: () {},
                                                          child: Image.asset(
                                                            "Images/Group 81121.png",
                                                            height: 25,
                                                          )),
                                                      const SizedBox(width: 4),
                                                      GestureDetector(
                                                          onTap: () {},
                                                          child: Image.asset(
                                                            "Images/Group 81119.png",
                                                            height: 25,
                                                          )),
                                                      const SizedBox(width: 4),
                                                      GestureDetector(
                                                          onTap: () {
                                                            launchUrl(
                                                                Uri.parse("mailto:" +
                                                                    (valueList[i]
                                                                            .temp![
                                                                                index]
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
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      23,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  6)),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.grey),
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
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                            color: colors
                                                                .secondary),
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            child: Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                            color: valueList[i]
                                                                        .temp![
                                                                            index]
                                                                        .taxNumber ==
                                                                    ""
                                                                ? colors.primary
                                                                : colors
                                                                    .secondary),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
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
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                            color: valueList[i]
                                                                        .temp![
                                                                            index]
                                                                        .subscriptionType !=
                                                                    "1"
                                                                ? Colors.red
                                                                : colors
                                                                    .secondary),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 3,
                                                                  bottom: 3),
                                                          child: Image.asset(
                                                              "Images/person.png",
                                                              color:
                                                                  Colors.white,
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
                                            height: 30,
                                          ),
                                          Center(
                                            child: Btn(
                                              height: 40,
                                              width: 150,
                                              title: "Contact Supplier",
                                              onPress: () {
                                                showDialogContactSuplier(
                                                    valueList[i]
                                                            .temp![index]
                                                            .id ??
                                                        "",
                                                    valueList[i]
                                                            .temp![index]
                                                            .sellerId ??
                                                        "");
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
  }

  List<ClientSupplierProductData> supplierDataList = [];
  GetSuppplierOrClientModel? getSuppplierOrClientModel;
  bool isLoading = false;

  List<TempModel> tempList = [];
  List<TempMode2> valueList = [];
  List<String> cityList = [];

  Future<void> getSupplier(String city) async {
    setState(() {
      isLoading = true;
    });
    String? userId = await getString(key: 'id');
    print('____userId______${userId}_________');
    var param = {
      "type": '1',
      "seller_id": userId == null ? "" : userId,
      'city': city.toString()
    };
    param["buisness_category"] = widget.isManu == null &&
            (businessName == null || businessName == 'Select All')
        ? ""
        : businessName == null
            ? widget.isManu
            : businessName == 'Select All'
                ? ''
                : businessName;
    print("parameter is in $param");

    apiBaseHelper.postAPICall(getSupplierOrClientApi, param).then((getData) {
      valueList.clear();
      List<String> list = [];
      cityList.clear();
      cityList.add("All");
      bool error = getData['error'];
      String msg = getData['message'];
      if (!error) {
        cateList.forEach((element) {
          if (getData['data'][element.name] != null &&
              !(list.contains(element.name))) {
            list.add(element.name ?? '');
            // var data = TempModel.fromJson(getData['data'][element.name]);
            tempList = (getData['data'][element.name] as List)
                .map((e) => TempModel.fromJson(e))
                .toList();
            getData['data'][element.name];
            valueList.add(TempMode2(
                temp: tempList, catName: tempList.first.categoryName));
          }
          // print("temp model is ${tempList.first.lat} ${tempList.first.lang}");
        });
        setState(() {
          isLoading = false;
        });
        print(
            "temp model is ${tempList.first.latitude} ${tempList.first.longitude}");

        for (int i = 0; i < valueList.length; i++) {
          for (int j = 0; j < valueList[i].temp!.length; j++) {
            if (valueList[i].temp![j].city.toString().trim().isNotEmpty &&
                !cityList.contains(valueList[i].temp![j].city.toString())) {
              cityList.add(valueList[i].temp![j].city! ?? '');
              print("${valueList[i].temp![j].city} City name");
            }
          }
        }
        // tempList.forEach((element) {
        //   print(element.address.toString() + "CITY NAME");
        // });
      } else {
        Fluttertoast.showToast(msg: msg);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> contactToSupplier(String itemId) async {
    //String? mobile = await getString(key: 'mobile');
    String? userId = await getString(key: 'id');
    var param = {
      "user_id": userId,
      "product_id": itemId ?? '438',
      "mobile": numCtr.text
    };
    print("contact supplier parameter ${param}");
    apiBaseHelper
        .postAPICall(contactSupplierOrClientApi, param)
        .then((getData) {
      bool error = getData['error'];
      String msg = getData['message'];
      if (!error) {
        Fluttertoast.showToast(msg: msg);
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  TextEditingController pinCodeController = new TextEditingController();
  final _Cotact = GlobalKey<FormState>();

  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController yourMobileNumber = TextEditingController();
  TextEditingController YourcityController = TextEditingController();
  bool verifie = false;
  String? controller;
  String? OTPIS;

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
        'sup_type': "Client",
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

  void showDialogContactSuplier(String productId, String sellerId) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId != "null" ? 250 : 400,
                width: MediaQuery.of(context).size.width / 1.5,
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
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
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
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
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
                                      decoration: new InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      maxLength: 10,
                                      controller: yourMobileNumber,
                                      decoration: new InputDecoration(
                                        counterText: "",
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      controller: YourcityController,
                                      decoration: new InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Btn(
                          height: 45,
                          width: 150,
                          title: "Send OTP",
                          onPress: () {
                            if (_Cotact.currentState!.validate()) {
                              print("gggggggggggggggg");
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
                height: 350,
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
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
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
                            'OTP : ${OTPIS}',
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
                      InkWell(
                        onTap: () {
                          if (controller == OTPIS) {
                            sendEnqury(productIddd, sellerId);
                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                        child: Container(
                          color: colors.primary,
                          width: 100,
                          height: 40,
                          child: const Center(
                              child: Text(
                            'Verify Otp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  var namee;

  var city2;

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
        'name': namee,
        'mobile': yourMobileNumber.text.toString(),
        'product_id': productid.toString(),
        'user_id': userId.toString(),
        'sup_type': "Client",
        'seller_id': sellerId ?? "",
        'city': city2
      });
    }

    request.headers.addAll(headers);
    print('_____sssdsdsfsdfsdfsd_____${request.fields}_________');

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

  searchProduct(String value) {
    if (value.isEmpty) {
      setState(() {});
    } else {
      final suggestions = tempList.where((element) {
        final productTitle = element.city!.toLowerCase();
        final input = value.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      tempList = suggestions;
      valueList = [];
      valueList
          .add(TempMode2(temp: tempList, catName: tempList.first.categoryName));
      setState(() {});
    }
  }
}
