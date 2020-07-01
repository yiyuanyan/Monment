import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/config/service_url.dart';
import 'package:monment/model/home_model.dart';
import 'package:monment/pages/home/content_list_item.dart';
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
        //elevation: 1,
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
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: getContentItems(context),
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
  List<Widget> getContentItems(BuildContext context){
    List<ContentLists> contentLists = Provide.value<IndexProvide>(context).contentLists;
    List<Widget> items = [];
    items.add(SwiperBanner(swipers: Provide.value<IndexProvide>(context).swipers,));
    contentLists.map((e){
      items.add(
        Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(15)),
          child: ContentListItem(id: e.id, image: fileURL+e.image, playTime: e.playTime, portrait: fileURL+e.portrait, title: e.title, tag: e.tag),
        ),
      );
    }).toList();
    return items;
  }
  Future<String> _getHomeInfo(BuildContext context) async{
    await Provide.value<IndexProvide>(context).getIndexSwiperBanners();
    await Provide.value<IndexProvide>(context).getIndexContentLists();
    if(Provide.value<IndexProvide>(context).barIconsStatusCode == 200 && Provide.value<IndexProvide>(context).contentListsStatusCode == 200){
      return "OK";
    }else{
      return "FALSE";
    }
  }
}
