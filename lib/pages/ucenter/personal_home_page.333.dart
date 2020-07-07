import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:monment/provide/personal_home_provide.dart';
import 'package:monment/provide/ucenter_provide.dart';
import 'package:monment/routers/application.dart';
import 'package:provide/provide.dart';

//随机颜色
Color slRandomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
  if (r == 0 || g == 0 || b == 0) return Colors.black;
  if (a == 0) return Colors.white;
  return Color.fromARGB(
    a,
    r != 255 ? r : Random.secure().nextInt(r),
    g != 255 ? g : Random.secure().nextInt(g),
    b != 255 ? b : Random.secure().nextInt(b),
  );
}

class PersonalHomePage extends StatefulWidget {
  final userId;
  PersonalHomePage({Key key, @required this.userId}) : super(key: key);

  @override
  _PersonalHomePageState createState() => _PersonalHomePageState();
}

//集成SingleTickerProviderStateMixin可使用控制器
class _PersonalHomePageState extends State<PersonalHomePage>
    with SingleTickerProviderStateMixin {
  Future<int> future;
  //滚动控制器
  ScrollController scrollController;
  //Tab控制器
  TabController tabController;
  //折叠预拉伸时appbar文字和按钮的透明度
  double opa = 0;
  //折叠预拉伸时appbar文字和按钮的颜色
  Color cusColor;
  //构造函数
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化控制器
    this.scrollController = ScrollController();
    //初始化控制器
    this.tabController = TabController(length: 2, vsync: this);
    //重点：给控制器增加滚动监听方法 弊端就是滚动就会重新build页面
    //this.scrollController.addListener(() {});
    _getUcenterInfo(context, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    print(Provide.value<UcenterProvide>(context).opa);
    return Scaffold(
      body: FutureBuilder(
        future: _getUcenterInfo(context, null),
        builder: (context, snapshot) {
          if (snapshot.data == "OK") {
            return NotificationListener(
              onNotification: (ScrollNotification notification){
                ScrollMetrics metrics = notification.metrics;
                print(metrics.pixels);
                if(metrics.pixels > 110){
                  setState(() {
                    this.opa = 0;
                  });
                }else{
                  setState(() {
                    this.opa = 1;
                  });
                }
                return true;
              },
              child: CustomScrollView(
                //自定义滚动试图
                controller: this.scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    //可折叠伸展AppBar
                    backgroundColor: Colors.white,
                    pinned: true, //是否顶部吸附
                    elevation: 0,
                    expandedHeight: Platform.isIOS == true
                        ? ScreenUtil().setHeight(233)
                        : ScreenUtil().setHeight(223), //appBar展开高度
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Application.router.pop(context);
                      },
                      color: this.opa == 1
                          ? Colors.white
                          : Colors.black,
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          print("点击了分享按钮");
                        },
                        color: this.opa == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      //AppBar内容与样式
                      centerTitle: true,
                      title: homeTitle(),
                      background: SliverTopBar(),
                    ),
                  ),
                  SliverPersistentHeader(
                    //可折叠AppBar底部栏
                    pinned: true, //是否可吸附
                    //自定义代理并且将控制器传入
                    delegate: MySliverPersistentHeaderDelegate(
                        tabController: this.tabController),
                  ),
                  //内容列表
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ListItem(
                        index: index,
                      );
                    }, childCount: 10),
                  ),
                ],
              ),
            );
          } else {
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

  Widget homeTitle() {
    return Text(
      "Daisy的主页",
      style: TextStyle(
        fontSize: ScreenUtil().setSp(18),
        color: Color.fromRGBO(0, 0, 0, this.opa == 1 ? 0 : 1),
      ),
    );
  }

  Future<String> _getUcenterInfo(BuildContext context, String user_id) async {
    if(user_id == null){
      return "OK";
    }else{
      await Provide.value<UcenterProvide>(context).getUcenter(user_id);
      if (Provide.value<UcenterProvide>(context).code == 200) {
        return "OK";
      } else {
        return "FALSE";
      }
    }
  }
}

//自定义代理Header代理，内附有样式
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  MySliverPersistentHeaderDelegate({@required this.tabController});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HeaderView();
  }

  @override
  double get maxExtent => ScreenUtil().setHeight(48);

  @override
  double get minExtent => ScreenUtil().setHeight(48);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      true; // 如果内容需要更新，设置为true
}

class HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<PersonalHomeProvide>(
      builder: (context, child, value) {
        return Material(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Divider(
                height: 1,
                color: Colors.grey[600],
              ),
              Container(
                height: ScreenUtil().setHeight(45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print("点击了动态按钮");
                              Provide.value<PersonalHomeProvide>(context)
                                  .changePersonalListTag(1);
                            },
                            child: Container(
                              height: ScreenUtil().setHeight(43),
                              child: Text(
                                "动态",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  color: value.personalListTag == 1
                                      ? Colors.blueAccent
                                      : Colors.black,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                          //动态标记线
                          Container(
                            height: ScreenUtil().setHeight(2),
                            width: ScreenUtil().setWidth(20),
                            color: value.personalListTag == 1
                                ? Colors.blueAccent
                                : Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print("点击了动作品钮");
                              Provide.value<PersonalHomeProvide>(context)
                                  .changePersonalListTag(2);
                            },
                            child: Container(
                              height: ScreenUtil().setHeight(43),
                              child: Text(
                                "作品",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  color: value.personalListTag == 2
                                      ? Colors.blueAccent
                                      : Colors.black,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                          //动态标记线
                          Container(
                            height: ScreenUtil().setHeight(2),
                            width: ScreenUtil().setWidth(20),
                            color: value.personalListTag == 2
                                ? Colors.blueAccent
                                : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey[600],
              ),
            ],
          ),
        );
      },
    );
  }
}

// SliverAppBar样式
class SliverTopBar extends StatefulWidget {
  @override
  _SliverTopBarState createState() => _SliverTopBarState();
}

class _SliverTopBarState extends State<SliverTopBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.asset(
              "assets/images/content/u214.jpg",
              fit: BoxFit.fitWidth,
              width: ScreenUtil().setWidth(375),
              height: ScreenUtil().setHeight(151),
            ),
            //个人信息
            Container(
              height: ScreenUtil().setHeight(100),
              padding: EdgeInsets.only(
                  left: ScreenUtil().setHeight(20),
                  right: ScreenUtil().setHeight(20),
                  top: ScreenUtil().setHeight(20)),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //用户名
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Daisy",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("点击了关注按钮");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(56),
                          height: ScreenUtil().setHeight(26),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                  //用户说明
                  Container(
                    child: Text(
                      "日剧日影混剪。微博：贪吃的Daisy",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "关注 26  |  粉丝 10.6w",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: ScreenUtil().setHeight(110),
          left: ScreenUtil().setWidth(20),
          child: Container(
            width: ScreenUtil().setWidth(50),
            height: ScreenUtil().setHeight(60),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/content/u167.png",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({Key key, @required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return index % 2 == 0 ? _getVideoItem() : _getMusicItem();
  }

  Widget _getMusicItem() {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setHeight(20),
          top: ScreenUtil().setHeight(20),
          right: ScreenUtil().setHeight(20)),
      height: ScreenUtil().setHeight(155),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              //头像
              Container(
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setHeight(40),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/content/u167.png",
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setHeight(40),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              //名称&时间
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Daisy",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    "02-03 发布了新视频",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(44)),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
            width: ScreenUtil().setWidth(290),
            height: ScreenUtil().setHeight(60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[200],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setHeight(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/content/u637.png")),
                  ),
                ),
                //SizedBox(width: ScreenUtil().setWidth(10),),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "林楚川",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "爱音乐，爱生活。",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("点击了关注");
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.blueAccent,
                    ),
                    child: Center(
                      child: Text(
                        "+ 关注",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          Divider(
            height: 1,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  Widget _getVideoItem() {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setHeight(20),
          top: ScreenUtil().setHeight(20),
          right: ScreenUtil().setHeight(20)),
      height: ScreenUtil().setHeight(408),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              //头像
              Container(
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setHeight(40),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/content/u167.png",
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setHeight(40),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              //名称&时间
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Daisy",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    "02-03 发布了新视频",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          //介绍
          Text(
            "「閃閃發光，炫彩奪目，心跳不已。卻又無可奈何地，非常輕易地動搖了我的世界。」",
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(12),
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          //视频图片
          InkWell(
            onTap: () {
              print("点击了视频");
            },
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(182),
                    width: ScreenUtil().setWidth(335),
                    decoration: BoxDecoration(
                      color: slRandomColor(),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/content/u150.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  //观看人数
                  Positioned(
                    bottom: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setWidth(20),
                    child: Container(
                      child: Text(
                        "5.6万观看",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  //视频时长
                  Positioned(
                    bottom: ScreenUtil().setHeight(20),
                    right: ScreenUtil().setWidth(20),
                    child: Container(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                      child: Center(
                        child: Text(
                          "01:45",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            "日剧片段：听说桐岛要退部",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          Container(
            height: ScreenUtil().setHeight(25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print("点击了喜欢");
                        },
                        child: Image(
                          image: AssetImage("assets/images/display/u305.png"),
                          width: ScreenUtil().setWidth(22),
                          height: ScreenUtil().setHeight(22),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(5),
                      ),
                      Text(
                        "1221",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print("点击了消息");
                        },
                        child: Image(
                          image: AssetImage("assets/images/display/u314.png"),
                          width: ScreenUtil().setWidth(22),
                          height: ScreenUtil().setHeight(22),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(5),
                      ),
                      Text(
                        "1688",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print("点击了分享");
                        },
                        child: Image(
                          image: AssetImage("assets/images/display/u311.png"),
                          width: ScreenUtil().setWidth(22),
                          height: ScreenUtil().setHeight(22),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(5),
                      ),
                      Text(
                        "245",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(14),
          ),
          Divider(
            height: 1,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
