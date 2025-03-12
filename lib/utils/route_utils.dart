import 'package:get/get.dart';
import 'package:kamala_update/screens/home_screen.dart';
import 'package:kamala_update/screens/login_screen.dart';
import 'package:kamala_update/screens/news_details.dart';
import 'package:kamala_update/utils/binding.dart';

class RouteUtils {
  static const String home = '/home';
  static const String login = '/login';
  static const String newsDetails = '/news-details';

  static final routes = {
    GetPage(
        name: RouteUtils.home,
        page: () => HomeScreen(),
        binding: homebinding()),
    GetPage(name: RouteUtils.login, page: () => LoginScreen()),
    GetPage(name: RouteUtils.newsDetails, page: () => NewsDetailsScreen()),
  };
}
