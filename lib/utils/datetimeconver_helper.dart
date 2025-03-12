String timeAgo(String? timestamp) {
  // Return empty string if timestamp is null or empty
  if (timestamp == null || timestamp.isEmpty) {
    return "";
  }

  try {
    // Parse the timestamp and convert it to local time
    DateTime dateTime = DateTime.parse(timestamp).toLocal();
    DateTime now = DateTime.now().toLocal();

    // Calculate the difference between now and the provided timestamp
    Duration difference = now.difference(dateTime);

    // Convert the difference into a human-readable format
    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return "$months month${months > 1 ? 's' : ''} ago";
    } else {
      int years = (difference.inDays / 365).floor();
      return "$years year${years > 1 ? 's' : ''} ago";
    }
  } catch (e) {
    // Handle parsing errors (e.g., invalid date format)
    return "Invalid Date";
  }
}
