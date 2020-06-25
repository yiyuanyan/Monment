import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
}