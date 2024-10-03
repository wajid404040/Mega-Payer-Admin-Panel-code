import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/method.dart';
import '../../core/helper/shared_pref_helper.dart';
import '../../core/route/route.dart';
import '../model/authorization/AuthorizationResponseModel.dart';
import '../model/general_setting/GeneralSettingsResponseModel.dart';
import '../model/global/response_model/response_model.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          if (isOnlyAcceptType) {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
            });
          } else {
            response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
          }
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(url, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.get(
            url,
          );
        }
      }

      print(params.toString());
      print('response ${response.body}');
      print('response ${response.statusCode}');
      print('url ${url.toString()}');
      print('token ${token.toString()}');

      if (response.statusCode == 200) {
        print('body ${response.body}');
        AuthorizationResponseModel testModel = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
        print(testModel.status);

        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
        if (model.remark == 'profile_incomplete') {
          Get.toNamed(RouteHelper.profileComplete);
        } else if (model.remark == 'unauthenticated') {
          sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
          sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
          Get.offAllNamed(RouteHelper.loginScreen);
        } else if (model.remark == 'kyc_verification') {
          Get.offAndToNamed(RouteHelper.kycScreen);
        } else if (model.remark == "unverified") {
          checkAndGotoNextStep(model);
        }

        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(false, 'Unauthorized', 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, 'Server Error', 500, response.body);
      } else {
        return ResponseModel(false, 'Something Wrong', 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, 'No Internet Connection', 503, '');
    } on FormatException {
      return ResponseModel(false, 'Bad Response Format!', 400, '');
    } catch (e) {
      return ResponseModel(false, 'Something Went Wrong', 499, '');
    }
  }

  void checkAndGotoNextStep(AuthorizationResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;

    bool isProfileCompleteEnable = responseModel.data?.user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileComplete);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(
        RouteHelper.twoFactorScreen,
      );
    } else {
      Get.offAndToNamed(RouteHelper.homeScreen);
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t = sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType = sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  storeGeneralSetting(GeneralSettingsResponseModel model) {
    String json = jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingsResponseModel getGSData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    return model;
  }

  SocialiteCredentials getSocialCredentialsConfigData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    SocialiteCredentials social = model.data?.generalSetting?.socialiteCredentials ?? SocialiteCredentials();
    return social;
  }

  String getSocialCredentialsRedirectUrl() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    String redirect = model.data?.socialLoginRedirect ?? "";
    return redirect;
  }

  bool isSocialAnyOfSocialLoginOptionEnable() {
    return getSocialCredentialsConfigData().google?.status == '1' || getSocialCredentialsConfigData().linkedin?.status == '1' || getSocialCredentialsConfigData().facebook?.status == '1';
  }

  bool getPasswordStrengthStatus() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool checkPasswordStrength = model.data?.generalSetting?.securePassword.toString() == '0' ? false : true;
    return checkPasswordStrength;
  }
}
