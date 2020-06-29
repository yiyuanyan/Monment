//内容显示页面
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/routers/application.dart';
import 'package:flutter/services.dart';
class DisplayPage extends StatelessWidget {
  final displayId;

  const DisplayPage({Key key, @required this.displayId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle _style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(_style);
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//        leading: IconButton(
//          onPressed: (){
//            Application.router.pop(context);
//          },
//          icon: Icon(Icons.arrow_back),
//          color: Colors.black,
//        ),
//      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -ScreenUtil().setHeight(31),
            left: 0,
            bottom: 0,
            right: 0,
            child: ListView(
              shrinkWrap: true,
              children: _contentListView(context),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Application.router.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),

          ),
        ],
      ),
    );
  }
  List<Widget> _contentListView(BuildContext context){
    List<Widget> items = [];
    items.add(_displayWidget());
    items.add(_recommendedWidget(context));
    return items;
  }
  //视频播放
  Widget _displayWidget(){
    return Container(
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(211),
      color: Colors.red,
      child: Image(
        image: AssetImage("assets/images/content/u214.jpg"),
        width: ScreenUtil().setWidth(375),
        height: ScreenUtil().setHeight(211),
        fit: BoxFit.cover,
      ),
    );
  }
  //介绍
  Widget _recommendedWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setHeight(15), right: ScreenUtil().setHeight(15), top: ScreenUtil().setHeight(10)),
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(200),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //头像名称
          Row(
            children: <Widget>[
              //头像
              ClipOval(
                child: Image(
                  image: AssetImage("assets/images/content/u160.png"),
                  width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setHeight(40),
                ),
              ),
              //名称日期
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Daisy",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "2017-10-07",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              //关注按钮
              InkWell(
                onTap: (){
                  print("点击了关注按钮");
                },
                child: Container(
                  width: ScreenUtil().setWidth(56),
                  height: ScreenUtil().setHeight(26),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      "+ 关注",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(13),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "日剧日影混剪：没有你的我",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  color: Colors.grey[600],
                ),
              ),
              Text(
                "#混剪  3456次播放",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5),),
              Text(
                "「閃閃發光，炫彩奪目，心跳不已。卻又無可奈何地，非常輕易地動搖了我的世界。」",
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      print("1111111111");
                    },
                    child: Container(
                      color: Colors.blueAccent,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              print("1111111111");
                            },
                            child: Image(
                              image: AssetImage("assets/images/display/u305.png"),
                              width: ScreenUtil().setWidth(24),
                              height: ScreenUtil().setHeight(24),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(5),
                          ),
                          Center(
                            child: Text(
                              "1221",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  Image(
                    image: AssetImage("assets/images/display/u311.png"),
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setHeight(24),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Center(
                    child: Text(
                      "245",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  Image(
                    image: AssetImage("assets/images/display/u314.png"),
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setHeight(24),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Center(
                    child: Text(
                      "1221",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  Image(
                    image: AssetImage("assets/images/display/u318.png"),
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setHeight(24),
                    //fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Center(
                    child: Text(
                      "缓存",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
