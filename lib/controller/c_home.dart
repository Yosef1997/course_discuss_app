import 'package:flutter/cupertino.dart';

class CHome extends ChangeNotifier {
  int _indexMenu = 0;
  int get indexMenu => _indexMenu;
  set indexMenu(int n) {
    _indexMenu = n;
    notifyListeners();
  }
}
