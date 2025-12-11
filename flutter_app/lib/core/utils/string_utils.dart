/// String utility functions
class StringUtils {
  /// Get initials from a name string
  /// Takes first letter of first two words and returns them in uppercase
  /// Example: "John Doe" -> "JD", "John" -> "J"
  static String getInitials(String name) {
    return name
        .split(' ')
        .take(2)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();
  }
}
