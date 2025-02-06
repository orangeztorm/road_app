// ignore_for_file: unnecessary_this

extension StringExtension on String {
  String capitalizeFirstWords() {
    final List<String> words = this.split("");

    for (int i = 0; i < this.length - 1; i++) {
      if (i == 0 || this[i - 1] == " ") {
        words[i] = words[i].toUpperCase();
      }
    }

    return words.join("");
  }

  String capitalizeFirstWord() {
    final List<String> words = this.split("");
    words[0] = words[0].toUpperCase();

    return words.join("");
  }

  String abbrToName() {
    final String value = this.toLowerCase();

    if (value == "ngn") {
      return "Nigerian Naira ($this)";
    } else if (value == "usd" || value == "usa") {
      return "United States Dollar ($this)";
    } else if (value == "gbp") {
      return "British Pounds ($this)";
    } else if (value == "eur") {
      return "British Euro ($this)";
    } else if (value == "gha" || value == "ghs") {
      return "Ghanaian Cedis ($this)";
    } else if (value == "ken" || value == "kes") {
      return "Kenyan Shilling ($this)";
    }

    return this;
  }

  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get removeDash => this.replaceAll('-', ' ');

  String get capitalizeFirstLetter => this[0].toUpperCase() + this.substring(1);
}
