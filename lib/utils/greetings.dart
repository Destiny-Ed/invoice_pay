/// Returns a greeting based on current time:
/// Good Morning (5:00 - 11:59)
/// Good Afternoon (12:00 - 16:59)
/// Good Evening (17:00 - 20:59)
/// Good Night (21:00 - 4:59)
String getTimeBasedGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning!';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon!';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening!';
  } else {
    return 'Good Night!';
  }
}

/// Optional: More personal with emoji
String getRichGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning! ☀️';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon! 🌤️';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening! 🌅';
  } else {
    return 'Good Night! 🌙';
  }
}
