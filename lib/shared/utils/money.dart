extension Money on double {
  String get ui {
    return toInt() == this ? toInt().toString() : toString();
  }
}
