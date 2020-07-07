import 'package:flutter/material.dart';
import 'package:monment/model/ucenter_model.dart';
import 'package:monment/service/service_method.dart';

class UcenterProvide with ChangeNotifier {
  int opa = 0;
  changeOpa(int a) {
    this.opa = a;
    notifyListeners();
  }

  UcenterModel _ucenterModel;
  int code;
  String message;
  UserInfo userInfo;
  List<UserDynamic> userDynamic;
  getUcenter(String user_id) async {
    String formData = "user_id/" + user_id;
    await request("getUcenter", formData: formData).then((value) {
      this._ucenterModel = UcenterModel.fromJson(value);
      if (this._ucenterModel.code == 200) {
        this.code = this._ucenterModel.code;
        this.message = this._ucenterModel.message;
        this.userInfo = this._ucenterModel.userInfo;
        this.userDynamic = this._ucenterModel.userDynamic;
      }
    });
    notifyListeners();
  }
}
