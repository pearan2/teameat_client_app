extension TEStringExtension on String? {
  bool isEmpty() {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }
}
