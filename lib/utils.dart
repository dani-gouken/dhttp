class Utils{
   static String enumToString(enumItem) {
    if (enumItem == null) return null;
    final _tmp = enumItem.toString().split('.')[1];
    return _tmp;
  }
}