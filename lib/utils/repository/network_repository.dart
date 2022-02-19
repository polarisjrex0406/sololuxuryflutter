import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solo_luxury/app/screens/login/login_screen.dart';
import 'package:solo_luxury/app/utils/colors.dart';
import 'package:solo_luxury/data/model/Authentication/login_model.dart';
import 'package:solo_luxury/data/model/Home/menu_model.dart';
import 'package:solo_luxury/data/model/profile/update_image_model.dart';
import 'package:solo_luxury/utils/app_constants.dart';
import 'package:solo_luxury/utils/common_methods.dart';
import 'package:solo_luxury/utils/network_dio/network_dio.dart';
import 'package:http/http.dart' as http;

import '../process_indicator.dart';

class NetworkRepository {
  static NetworkRepository _networkRepository = NetworkRepository._internal();
  static final dataStorage = GetStorage();

  factory NetworkRepository() {
    return _networkRepository;
  }
  NetworkRepository._internal();

  FocusNode searchFocus = new FocusNode();

  // StreamController gameDetailStream = new StreamController
  //     .broadcast(); // for stream builder - to add data in stramCiontroller
//Login
  userLogin(context, authUserData) async {
    try {
      final authUserResponse = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: '${AppConstants.apiEndPoint}${AppConstants.signup}',
        data: authUserData,
      );
      return checkResponse(
          authUserResponse, LoginModel.fromJson(authUserResponse['body']));
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  // Image upload
  Future uploadImage({context, selectedImage, uploadType}) async {
    String url = '${AppConstants.apiEndPoint}/upload/compress/$uploadType';
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$url"),
    );

    final token = await NetworkDioHttp.getHeaders();
    request.headers.addAll(token);
    request.files.add(
        await http.MultipartFile.fromPath("image", selectedImage.toString()));
    if (context != null) Circle().show(context);
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var parsedJson = await json.decode(responseString);

    if (context != null) Circle().hide(context);
    if (response.statusCode == 200) {
      return UpdateImageModel.fromJson(parsedJson);
    } else {
      return '';
    }
  }

  // Menu with Category

  Future getMenu() async {

    String url = '${AppConstants.apiEndPointNew}${AppConstants.menuEndPoint}';
    final header = await NetworkDioHttp.getTestHeaders();
    print("url -> "+url);
    print("header -> " + header.toString());
    http.Response response = await http.get(
      Uri.parse(url),
      headers: header
    );
    //request.headers.addAll(token);
    if(response!=null){
      print("response.statusCode -> ");
      print(response.statusCode);
    }
    if (response!=null && response.statusCode == 200) {
      var parsedJson = await json.decode(response.body);
      return MenuModel.fromJson(parsedJson);
    } else {
      return null;
    }

  }


  Future<void> checkResponse(
    response,
    modelResponse,
  ) async {
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      if (response['body']['status'] == 200 ||
          response['body']['status'] == "200") {
        return modelResponse;
      } else if (response['body']['status'] == 500 ||
          response['body']['status'] == "500") {
        return modelResponse;
      } else {
        showErrorDialog(message: response['body']['message']);
      }
    } else {
      if (response['body']['status'] == 401 ||
          response['body']['status'] == '401') {
        showErrorDialog(message: response['body']['message']);
        Future.delayed(Duration(seconds: 2), () {
          Get.to(LoginScreen());
        });
      } else {
        showErrorDialog(message: response['body']['message']);
      }
    }
  }

  void showErrorDialog({required String message}) {
    CommonMethod().getXSnackBar("Error", message.toString(), red);
  }
}

//  final authUserData = {
//           "old_token": dataStorage.read('token').toString(),
//           "refresh_token": dataStorage.read('refreshToken').toString(),
//         };
//         print(authUserData);
//         // GenerateTokenModel authResponse =
//         //     await generateToken(context, authUserData);

//         final authUserResponse = await NetworkDioHttp.postDioHttpMethod(
//           context: context,
//           url: '${AppConstants.apiEndPoint}${AppConstants.generateToken}',
//           data: authUserData,
//         );
//         print('-----------------------$authUserResponse');
//         GenerateTokenModel responseData =
//             GenerateTokenModel.fromJson(authUserResponse['body']);
//         if (responseData.status == 200) {
//           dataStorage.write('token', responseData.data!.token);
//           dataStorage.write('refreshToken', responseData.data!.refreshToken);
//           SuccessDialog.showSuccessDialog(
//             successMessage: responseData.message.toString(),
//             onPressed: () {
//               Get.offAll(LoginScreen());
//             },
//           );
//         }
