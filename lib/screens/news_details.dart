import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamala_update/controller/home_controller.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final article = homeController.selectedArtical.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kamala Update',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with rounded corners
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),

            // Title
            Text(
              article.title ?? "No Title Available",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Publication Date
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 18, color: Colors.redAccent),
                const SizedBox(width: 5),
                Text(
                  "Published on: ${article.publishedAt ?? "Unknown"}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Author Name
            if (article.author != null)
              Row(
                children: [
                  const Icon(Icons.person, size: 18, color: Colors.blueAccent),
                  const SizedBox(width: 5),
                  Text(
                    "By: ${article.author}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            // Content in a Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  article.content ?? "No content available",
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            // Read More Button
            const SizedBox(height: 20),
            if (article.url != null)
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(Icons.open_in_new, color: Colors.white),
                  label: const Text(
                    "Read Full Article",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
