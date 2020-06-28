import 'package:flutter/material.dart';
import 'package:monment/service/service_method.dart';
import '../model/home_model.dart';
import '../config/service_url.dart';
import 'package:provide/provide.dart';

class IndexProvide with ChangeNotifier {
  int barIconsStatusCode;
  String barIconsMessage;
  List<IconList> iconList;
  BottomIconsModel _bottomIconsModel;

  int bannerStatusCode;
  String bannerMessage;
  List<Swipers> swipers;
  BannerModel _bannerModel;

  getBottomBarIcons() async{
    await request("getBottomBarIcons").then((value){
      _bottomIconsModel = BottomIconsModel.fromJson(value);
      if(_bottomIconsModel.statusCode == 200){
        this.barIconsStatusCode = _bottomIconsModel.statusCode;
        this.barIconsMessage = _bottomIconsModel.message;
        this.iconList = _bottomIconsModel.iconList;
      }
    });
    notifyListeners();
  }
  getIndexSwiperBanners() async{
    await request("getIndexSwiperBanners").then((value){
      _bannerModel = BannerModel.fromJson(value);
      if(_bannerModel.statusCode == 200){
        this.bannerStatusCode = _bannerModel.statusCode;
        this.bannerMessage = _bannerModel.message;
        this.swipers = _bannerModel.swipers;
      }
    });
    notifyListeners();
  }
  ContentListsModel _contentListsModel;
  int contentListsStatusCode;
  String contentListsMessage;
  List<ContentLists> contentLists;
  getIndexContentLists() async{
    await request("getIndexContentLists").then((value){
      _contentListsModel = ContentListsModel.fromJson(value);

      if(_contentListsModel.statusCode == 200){
        this.contentListsStatusCode = _contentListsModel.statusCode;
        this.contentListsMessage = _contentListsModel.message;
        this.contentLists = _contentListsModel.contentLists;
      }
    });
    notifyListeners();
  }

}