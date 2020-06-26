import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/model/home_model.dart';
import 'package:monment/pages/home/swiper_banner.dart';
import 'package:monment/provide/index_provide.dart';
import 'package:provide/provide.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("首页", style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.grey[600]),),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(
            highlightColor: Colors.white,
            splashColor: Colors.white,
            color: Colors.blue,
            onPressed: (){
              print("点击搜索按钮");
            },
            icon: ImageIcon(AssetImage("assets/images/appbar/u144.png")),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getHomeInfo(context),
        builder: (BuildContext context, snapshot){
          if(snapshot.data == "OK"){
            return Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SwiperBanner(swipers: Provide.value<IndexProvide>(context).swipers,),
                ],
              ),
            );
          }else{
            return Container(
              child: Center(
                child: Text("正在加载中....."),
              ),
            );
          }
        },
      ),
    );
  }
  Future<String> _getHomeInfo(BuildContext context) async{
    await Provide.value<IndexProvide>(context).getIndexSwiperBanners();
    if(Provide.value<IndexProvide>(context).barIconsStatusCode == 200){
      return "OK";
    }else{
      return "FALSE";
    }
  }
}
