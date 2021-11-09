import 'package:mim_prototype/networking/api_helper.dart';

class NewsServices {

  /// This to use the NETWORKING METHODS [GET, POST, DELETE, PUT] customized to the system
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> getNews({required int page, required int perPage}) async {
    // defining URI for the called endpoint
    Uri endpoint = ApiBaseHelper.baseUri.replace(queryParameters: {
      "content_type": "1",
      "app_id": "2",
      "per_page": "$perPage",
      "page": "$page",
    });
    return await _helper.get(endpoint);
  }
}
