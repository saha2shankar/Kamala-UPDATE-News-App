import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamala_update/controller/home_controller.dart';
import 'package:kamala_update/models/news_model.dart';
import 'package:kamala_update/utils/constants.dart';
import 'package:kamala_update/utils/datetimeconver_helper.dart';
import 'package:kamala_update/utils/route_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    TextEditingController searchController = TextEditingController();

    Future<void> initData() async {
      await homeController.initData();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          // Notification Icon
          IconButton(
            onPressed: () {
              Get.toNamed('/login');
              // Add notification logic here
            },
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          // Theme Toggle Icon
          Obx(() => IconButton(
                onPressed: () {
                  homeController.toggleTheme(); // Toggle theme
                },
                icon: Icon(
                  homeController.isDarkModeOn.value
                      ? Icons.wb_sunny // Light mode icon
                      : Icons.nightlight_round, // Dark mode icon
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: initData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "search News...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {
                  if (value.isEmpty) {
                    homeController.filteredArtical.value =
                        (homeController.newsModel.value.articles ?? []);
                  } else {
                    homeController.filterNews(value);
                  }
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (homeController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (homeController.filteredArtical == null ||
                    homeController.filteredArtical.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'Nothing found? Please check your Internet!'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: initData,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: homeController.filteredArtical.length,
                    itemBuilder: (context, index) {
                      Article article = homeController.filteredArtical[index];
                      return NewsCard(article: article);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => SalomonBottomBar(
            currentIndex: homeController.selectedIndex.value,
            selectedItemColor: const Color(0xff6200ee),
            unselectedItemColor: const Color(0xff757575),
            onTap: (index) {
              homeController.changeIndex(index); // Update index using GetX
            },
            items: _navBarItems,
          )),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Article article;

  NewsCard({super.key, required this.article});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        homeController.selectedArtical.value = article;
        Get.toNamed("/news-details");
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            // Add navigation or action when the card is tapped
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with fallback and gradient overlay
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    // Image or fallback container
                    article.urlToImage != null
                        ? Image.network(
                            article.urlToImage!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildImageFallback(context);
                            },
                          )
                        : _buildImageFallback(context),
                    // Gradient overlay for better text contrast
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    // Title on the image
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        article.title ?? "No Title",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Content below the image
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Text(
                      article.description ?? "No Description",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // Source and date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          article.source?.name ?? 'Unknown Source',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          timeAgo(article.publishedAt ?? 'No date'),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fallback widget for image loading errors
  Widget _buildImageFallback(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      child: Center(
        child: Text(
          "Breaking News!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite_border),
    title: const Text("Likes"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("Search"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal,
  ),
];
