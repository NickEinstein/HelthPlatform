extension Lists on List {
  bool hasNextItem(item) {
    return indexOf(item) < length - 1;
  }

  bool hasPreviousItem(item) {
    return indexOf(item) > 0;
  }

  bool hasNextIndex(int index) {
    return index < length - 1;
  }

  bool hasPreviousIndex(int index) {
    return index > 0;
  }

  nextItem(item) {
    return this[indexOf(item) + 1];
  }
}
