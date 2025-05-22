extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return "";
    return "${trim()[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeAll() {
    List<String> words = split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        capitalizedWords.add(word[0].toUpperCase() + word.substring(1));
      }
    }

    return capitalizedWords.join(' ');
  }

  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
}
