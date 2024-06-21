extension TEListExtension<T> on List<T> {
  List<T> reorder(int oldIdx, int newIdx) {
    if (oldIdx < 0 || oldIdx >= length || newIdx < 0) {
      throw 'index is out of range';
    }
    final newList = [...this];
    final oldTarget = newList.removeAt(oldIdx);
    newList.insert(newIdx, oldTarget);
    return newList;
  }
}
