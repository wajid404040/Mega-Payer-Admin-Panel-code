import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/method.dart';
import '../../model/global/response_model/response_model.dart';
import '../../../data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/auth/verification/email_verification_model.dart';


class LoginRepo extends GetConnect {
  SharedPreferences sharedPreferences;
  ApiClient apiClient;

  LoginRepo({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel> loginUser(String email,String password) async{
    Map<String, String> map = {'username': email, 'password': password};
    String url = '${UrlContainer.baseUrl}${UrlContainer.loginEndPoint}';
    print(map.toString());
    ResponseModel model=await apiClient.request(url, Method.postMethod, map,passHeader: false);
    print(model.responseJson);
    return model;
  }


  Future<String> forgetPassword(String type, String value) async {

    final map                     =  modelToMap(value, type);
    String url                    =  '${UrlContainer.baseUrl}${UrlContainer.forgetPasswordEndPoint}';
    final response                =  await apiClient.request(url, Method.postMethod,map,isOnlyAcceptType: true,passHeader: true);

    EmailVerificationModel model  =   EmailVerificationModel.fromJson(jsonDecode(response.responseJson));

    if (model.message?.success != null) {
      sharedPreferences.setString(
          SharedPreferenceHelper.userEmailKey, model.data?.email ?? '');
      String token=model.data?.token??'';
      sharedPreferences.setString(SharedPreferenceHelper.resetPassTokenKey, token);

      CustomSnackbar.showCustomSnackbar(
          errorList: [],
          msg:
              ['Password reset email sent to ${model.data?.email ?? 'your email'}'],
          isError: false);
      return model.data?.email??'';
    }
    else {
      CustomSnackbar.showCustomSnackbar(
          errorList: model.message!.error ?? ['Something went wrong'], msg: [''], isError: true);
      return '';
    }
  }

  Map<String, String> modelToMap(String value, String type) {
    Map<String, String> map = {'type': type, 'value': value};
    return map;
  }

  Future<EmailVerificationModel> verifyForgetPassCode(String code) async {
    String? email                   = sharedPreferences.getString(SharedPreferenceHelper.userEmailKey) ?? '';
    Map<String, String> map         = {'code': code, 'email': email};

    Uri url                         = Uri.parse('${UrlContainer.baseUrl}${UrlContainer.passwordVerifyEndPoint}');

    final response                  = await http.post(url, body: map, headers: {
      "Accept": "application/json",
    });

    EmailVerificationModel model     = EmailVerificationModel.fromJson(jsonDecode(response.body));
    if (model.message?.success != null) {
      model.setCode(200);
      return model;
    } else {
      model.setCode(400);
      return model;
    }
  }

  Future<EmailVerificationModel> resetPassword(
      String email, String password,String token) async {
    Map<String, String> map = {
      'token': token,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };
    Uri url = Uri.parse(
        '${UrlContainer.baseUrl}${UrlContainer.resetPasswordEndPoint}');
    final response = await http.post(url, body: map, headers: {
      "Accept": "application/json",
    });
    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.body));
    if (model.message?.success != null) {
      CustomSnackbar.showCustomSnackbar(
          errorList: [],
          msg: [model.message?.success.toString() ?? ''],
          isError: false);
      model.setCode(200);
      return model;
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: model.message!.error ?? [], msg: [''], isError: true);
      model.setCode(400);
      return model;
    }
  }


  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken =
          apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ??
              '';
    } else {
      deviceToken = '';
    }
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;
    if (deviceToken.isEmpty) {
      firebaseMessaging.getToken().then((fcmDeviceToken) async {
        success = await sendUpdatedToken(fcmDeviceToken ?? '');
      });
    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        if (deviceToken == fcmDeviceToken) {
          success = true;
        } else {
          apiClient.sharedPreferences.setString(
              SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
          success = await sendUpdatedToken(fcmDeviceToken);
        }
      });


    }
    return success;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url='${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String,String>map = deviceTokenMap(deviceToken);
    await apiClient.request(url,Method.postMethod,map,passHeader: true);
    return true;
  }




  Map<String,String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }
}
