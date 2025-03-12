import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamala_update/models/news_model.dart';
import 'package:kamala_update/services/news_service.dart';
import 'package:kamala_update/utils/sharedpreferences.dart';

class HomeController extends GetxController {
  var isDarkModeOn = false.obs;
  var selectedIndex = 0.obs; // Reactive variable for selected index
  var isLoading = false.obs;
  var newsModel = NewsModel().obs;
  var filteredArtical = <Article>[].obs;
  var selectedArtical = Article().obs;
  initData() async {
    try {
      isLoading.value = true;
      var res = await NewsService.fetchNews();
      if (res != null) {
        newsModel.value = NewsModel.fromJson(res);
        filteredArtical.value = newsModel.value.articles ?? [];
      }

      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index; // Update the selected index
  }

  @override
  void onInit() {
    super.onInit();
    loadThemePreference(); // Load saved theme preference
    initData();
  }

  Future<void> loadThemePreference() async {
    isDarkModeOn.value = await Sharedpreferences.loadThemePreference();
  }

  void toggleTheme() async {
    isDarkModeOn.value = !isDarkModeOn.value;
    await Sharedpreferences.saveThemePreference(
        isDarkModeOn.value); // Save preference
    Get.changeThemeMode(
      isDarkModeOn.value ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void filterNews(String value) {
    isLoading.value = true;

    String searchText = value.trim().toLowerCase();

    if (searchText.isEmpty) {
      filteredArtical.value =
          filteredArtical; // Restore full list if search is empty
    } else {
      filteredArtical.value = filteredArtical.where((article) {
        return (article.title ?? "").toLowerCase().contains(searchText) ||
            (article.description ?? "").toLowerCase().contains(searchText) ||
            (article.author ?? "").toLowerCase().contains(searchText);
      }).toList();
    }

    isLoading.value = false;
  }
}
