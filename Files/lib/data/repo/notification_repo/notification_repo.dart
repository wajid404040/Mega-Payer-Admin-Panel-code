
import 'package:local_coin/constants/method.dart';

import '../../../core/utils/url_container.dart';
import '../../../data/services/api_service.dart';

class NotificationRepo{

  ApiClient apiClient;
  NotificationRepo({required this.apiClient});

  Future<dynamic>loadAllNotification(int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.notificationEndPoint}?page=$page';
    final response=await apiClient.request(url,Method.getMethod,null,passHeader: true);
    return response;
  }

  Future<dynamic>readNotification(int notificationId)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.readNotificationEndPoint}$notificationId';
    final response=await apiClient.request(url,Method.getMethod,null,passHeader: true);
    return response;
  }


}