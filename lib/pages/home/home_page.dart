import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/pages/home/swiper_banner.dart';
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
      body: Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SwiperBanner(),
          ],
        ),
      ),
    );
  }
}
