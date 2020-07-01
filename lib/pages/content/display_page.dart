//内容显示页面
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/config/service_url.dart';
import 'package:monment/model/display_model.dart';
import 'package:monment/provide/display_provide.dart';
import 'package:monment/routers/application.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
class DisplayPage extends StatelessWidget {
  final displayId;

  const DisplayPage({Key key, @required this.displayId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle _style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(_style);
    VideoInfo videoInfo;
    List<Relevant> relevant;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getDisplayContent(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data == "OK"){
            videoInfo = Provide.value<DisplayProvide>(context).videoInfo;
            relevant = Provide.value<DisplayProvide>(context).relevant;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        print("点击了ID为"+videoInfo.id.toString()+"视频");
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(375),
                        height: ScreenUtil().setHeight(211),
                        color: Colors.brown,
                        child: _displayWidget(videoInfo),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 20,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: (){
                          Application.router.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    children: _contentListView(context, videoInfo, relevant),
                  ),
                ),
              ],
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

  Future<String> getDisplayContent(BuildContext context) async{
    await Provide.value<DisplayProvide>(context).getDisplayContent();
    int displayCode = Provide.value<DisplayProvide>(context).stateCode;
    if(displayCode == 200){
      return "OK";
    }else{
      return "FALSE";
    }
  }


  List<Widget> _contentListView(BuildContext context, VideoInfo videoInfo, List<Relevant> relevant){
    List<Widget> items = [];
    items.add(_recommendedWidget(context, videoInfo));
    items.add(_title());
//    items.add(_displayItems(context, 1));
//    items.add(_displayItems(context, 1));
//    items.add(_displayItems(context, 1));
//    items.add(_displayItems(context, 1));
    relevant.asMap().keys.map((index){
      items.add(_displayItems(context, index, relevant[index]));
    }).toList();
    items.add(SizedBox(height: ScreenUtil().setHeight(20),));
    return items;
  }
  //视频播放
  Widget _displayWidget(VideoInfo videoInfo){
    print(fileURL + videoInfo.videoPath.toString());
    return Container(
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(211),
      color: Colors.white,
      child: Image(
        image: NetworkImage(fileURL + videoInfo.videoPath.toString()),
        width: ScreenUtil().setWidth(375),
        height: ScreenUtil().setHeight(211),
        fit: BoxFit.cover,
      ),
    );
  }
  //介绍
  Widget _recommendedWidget(BuildContext context, VideoInfo videoInfo){
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setHeight(15), right: ScreenUtil().setHeight(15), top: ScreenUtil().setHeight(10)),
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(220),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //头像名称
          Row(
            children: <Widget>[
              //头像
              InkWell(
                onTap: (){
                  print("点击了头像");
                },
                child: ClipOval(
                  child: Image(
                    //image: AssetImage("assets/images/content/u160.png"),
                    image: NetworkImage(fileURL + videoInfo.userImg.toString()),
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setHeight(40),
                  ),
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
                      videoInfo.userName.toString(),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      videoInfo.regTime.toString(),
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
                videoInfo.videoName.toString(),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  color: Colors.grey[600],
                ),
              ),
              Text(
                videoInfo.videoTag.toString(),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5),),
              Text(
                videoInfo.videoDesc.toString(),
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(15),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      print("点击了喜欢按钮");
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage("assets/images/display/u305.png"),
                            width: ScreenUtil().setWidth(24),
                            height: ScreenUtil().setHeight(24),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(5),
                          ),
                          Center(
                            child: Text(
                              videoInfo.videoLike.toString(),
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
                    width: ScreenUtil().setWidth(40),
                  ),
                  InkWell(
                    onTap: (){
                      print("点击了分享按钮");
                    },
                    child: Row(
                      children: <Widget>[
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
                            videoInfo.videoShare.toString(),
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(40),
                  ),
                  InkWell(
                    onTap: (){
                      print("点击了消息按钮");
                    },
                    child: Row(
                      children: <Widget>[
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
                            videoInfo.videoMessage.toString(),
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(40),
                  ),
                  InkWell(
                    onTap: (){
                      print("点击了缓存按钮");
                    },
                    child: Row(
                      children: <Widget>[
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
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _title(){
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setHeight(15), right: ScreenUtil().setHeight(15), top: ScreenUtil().setHeight(20)),
      child: Text(
        "相关视频推荐",
        style: TextStyle(
          fontSize: ScreenUtil().setSp(14),
          color: Colors.grey[600],
        ),
      ),
    );
  }
  //items
  Widget _displayItems(BuildContext context, int index, Relevant relevant){
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.white,
      //hoverColor: Colors.white,
      //focusColor: Colors.white,
      onTap: (){
        print("点击了第" +index.toString()+ "item");
        Application.router.navigateTo(context, "/display?displayId="+relevant.id.toString());
      },
      child: Container(
        padding: EdgeInsets.only(left: ScreenUtil().setHeight(15), right: ScreenUtil().setHeight(15), top: ScreenUtil().setHeight(20)),
        //height: ScreenUtil().setHeight(80),
        //width: ScreenUtil().setWidth(375),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(120),
                  height: ScreenUtil().setHeight(94),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(image: NetworkImage(fileURL + relevant.thumb.toString())),
                  ),
                ),
                Positioned(
                  width: ScreenUtil().setWidth(39),
                  height: ScreenUtil().setHeight(20),
                  bottom: ScreenUtil().setHeight(10),
                  right: ScreenUtil().setWidth(10),
                  child: Container(
                    width: ScreenUtil().setWidth(39),
                    height: ScreenUtil().setHeight(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        relevant.playTime.toString(),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: ScreenUtil().setWidth(15),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  relevant.title.toString(),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  relevant.tag.toString(),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
