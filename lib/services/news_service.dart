import 'package:flutter/material.dart';
import 'package:kamala_update/utils/api_helper.dart';

class NewsService {
  static ApiHelper apiHelper = ApiHelper();
  static Future<dynamic> fetchNews() async {
    try {
      var response = await apiHelper.get(
          'everything?q=tesla&from=2025-01-21&sortBy=publishedAt&apiKey=964a7f114db64586b0d7dd3f6570fcb3');
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
