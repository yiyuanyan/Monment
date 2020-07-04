import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class PersonalHomeProvide with ChangeNotifier {
  int personalListTag = 0;
  double shrinkOffset = 0;
  changePersonalListTag(int tag) {
    this.personalListTag = tag;
    notifyListeners();
  }

  changeShrinkOffset(double shrinkOffset) {
    this.shrinkOffset = shrinkOffset;
    notifyListeners();
  }
}
