import 'package:flutter/material.dart';
import 'package:monment/model/display_model.dart';
import 'package:monment/service/service_method.dart';
import 'package:provide/provide.dart';

class DisplayProvide with ChangeNotifier{
  VideoInfo videoInfo;
  List<Relevant> relevant;
  int stateCode;
  String message;
  DisplayModel _displayModel;
  getDisplayContent() async{
    await request("getDisplayContent").then((value){
      _displayModel = DisplayModel.fromJson(value);
      if(_displayModel.stateCode == 200){
        this.videoInfo = _displayModel.videoInfo;
        this.relevant = _displayModel.relevant;
        this.stateCode = _displayModel.stateCode;
        this.message = _displayModel.message;
      }else{
        print("ERROR:"+_displayModel.stateCode.toString());
      }
    });
    notifyListeners();
  }
}