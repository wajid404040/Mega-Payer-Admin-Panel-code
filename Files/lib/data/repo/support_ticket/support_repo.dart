import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:local_coin/constants/method.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/data/model/authorization/AuthorizationResponseModel.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/support/new_ticket_store_model.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

class SupportTicketRepo {
  ApiClient apiClient;
  SupportTicketRepo({required this.apiClient});

  Future<ResponseModel> getCommunityGroupListList() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.communityGroupsEndPoint}";
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> getSupportMethodsList() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.supportMethodsEndPoint}";
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> getSupportTicketList(String page) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.supportListEndPoint}?page=$page";
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> storeTicket(TicketStoreModel model) async {
    apiClient.initToken();

    String url = "${UrlContainer.baseUrl}${UrlContainer.storeSupportEndPoint}";

    Map<String, String> map = {'subject': model.subject, 'message': model.message, 'priority': model.priority};

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

    if (model.list != null && model.list!.isNotEmpty) {
      for (var file in model.list!) {
        request.files.add(http.MultipartFile('attachments[]', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
      }
    }

    request.fields.addAll(map);
    http.StreamedResponse response = await request.send();

    String jsonResponse = await response.stream.bytesToString();
    print("-=----------------------$jsonResponse");
    AuthorizationResponseModel authorization = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

    if (authorization.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      // CustomSnackBar.success(successList: authorization.message?.success ?? []);
      return true;
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: authorization.message?.error ?? [MyStrings.error], msg: [], isError: true);
      return false;
    }
  }

  Future<dynamic> getSingleTicket(String ticketId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.supportViewEndPoint}/$ticketId';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> replyTicket(
    String message,
    List<File> fileList,
    String ticketId,
  ) async {
    apiClient.initToken();

    try {
      String url = "${UrlContainer.baseUrl}${UrlContainer.supportReplyEndPoint}/$ticketId";
      print(url);
      Map<String, String> map = {
        'message': message.toString(),
      };
      print(fileList.map((e) => e.path));
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

      for (var file in fileList) {
        request.files.add(http.MultipartFile('attachments[]', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
      }

      request.fields.addAll(map);
      http.StreamedResponse response = await request.send();

      String jsonResponse = await response.stream.bytesToString();
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

      print("-=----------------------$jsonResponse");

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        // CustomSnackBar.success(successList: model.message?.success ?? []);
        return true;
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.error], msg: [], isError: true);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> closeTicket(String ticketId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.supportCloseEndPoint}/$ticketId';
    ResponseModel response = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return response;
  }
}

class ReplyTicketModel {
  final String? message;
  final List<File>? fileList;

  ReplyTicketModel(this.message, this.fileList);
}
