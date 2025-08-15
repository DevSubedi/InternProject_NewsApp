class DateTimeService {
  String dateParser(String time) {
    final publishedDate = DateTime.parse(time);
    final now = DateTime.now().toUtc();
    final difference = now.difference(publishedDate);

    String timeAgo(Duration diff) {
      if (diff.inSeconds < 60) {
        return '${diff.inSeconds}s ago';
      } else if (diff.inMinutes < 60) {
        return '${diff.inMinutes}m ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}h ago';
      } else if (diff.inDays < 7) {
        return '${diff.inDays}d ago';
      } else {
        return '${(diff.inDays / 7).floor()}w ago';
      }
    }

    return timeAgo(difference);
  }
}
