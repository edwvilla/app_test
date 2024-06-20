extension Price on String {
  String get getFormattedPrice {
    return '\$ $this';
  }
}

extension Capitalize on String {
  String get capitalizeFirstLetter {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
