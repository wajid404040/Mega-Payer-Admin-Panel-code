import 'dart:convert';

import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/authorization/AuthorizationResponseModel.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/kyc/KycResponseModel.dart';
import '../../services/api_service.dart';
import 'package:http/http.dart' as http;

class KycRepo {
  ApiClient apiClient;
  KycRepo({required this.apiClient});

  Future<KycResponseModel> getKycData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.kycFormUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      KycResponseModel model = KycResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        return model;
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
        return model;
      }
    } else {
      return KycResponseModel();
    }
  }

  List<Map<String, String>> fieldList = [];
  List<ModelDynamicValue> filesList = [];

  Future<AuthorizationResponseModel> submitKycData(List<KycFormModel> list) async {
    apiClient.initToken();
    await modelToMap(list);
    String url = '${UrlContainer.baseUrl}${UrlContainer.kycSubmitUrl}';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    Map<String, String> finalMap = {};

    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

    for (var file in filesList) {
      request.files.add(http.MultipartFile(file.key ?? '', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
    }

    request.fields.addAll(finalMap);

    http.StreamedResponse response = await request.send();

    String jsonResponse = await response.stream.bytesToString();
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

    return model;
  }

  Future<dynamic> modelToMap(List<KycFormModel> list) async {
    for (var e in list) {
      if (e.type == 'checkbox') {
        if (e.cbSelected != null && e.cbSelected!.isNotEmpty) {
          for (int i = 0; i < e.cbSelected!.length; i++) {
            fieldList.add({'${e.label}[$i]': e.cbSelected![i]});
          }
        }
      } else if (e.type == 'file') {
        if (e.imageFile != null) {
          filesList.add(ModelDynamicValue(e.label, e.imageFile!));
        }
      } else {
        if (e.selectedValue != null && e.selectedValue.toString().isNotEmpty) {
          fieldList.add({e.label ?? '': e.selectedValue});
        }
      }
    }
  }
}

class ModelDynamicValue {
  String? key;
  dynamic value;

  ModelDynamicValue(this.key, this.value);
}
