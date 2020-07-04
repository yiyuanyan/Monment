import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:monment/routers/application.dart';

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
    //重点：给控制器增加滚动监听方法
    this.scrollController.addListener(() {
      if (scrollController.offset > 100) {
        setState(() {
          cusColor = Colors.black;
          opa = 1;
        });
      } else {
        setState(() {
          opa = 0;
          cusColor = Colors.white;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          //自定义滚动试图
          controller: this.scrollController,
          slivers: <Widget>[
            SliverAppBar(
              //可折叠伸展AppBar
              backgroundColor: Colors.white,
              pinned: true, //是否顶部吸附
              elevation: 0,
              expandedHeight: ScreenUtil().setHeight(225), //appBar展开高度
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Application.router.pop(context);
                },
                color: cusColor,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    print("点击了分享按钮");
                  },
                  color: cusColor,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                //AppBar内容与样式
                centerTitle: true,
                title: homeTitle(opa),
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
                return Container(
                  height: ScreenUtil().setHeight(375),
                  color: slRandomColor(),
                );
              }, childCount: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeTitle(double opa) {
    return Text(
      "Daisy的主页",
      style: TextStyle(
        fontSize: ScreenUtil().setSp(18),
        color: Color.fromRGBO(0, 0, 0, opa),
      ),
    );
  }
}

//自定义代理Header代理，内附有样式
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  MySliverPersistentHeaderDelegate({@required this.tabController});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Divider(
            height: 1,
            color: Colors.grey[600],
          ),
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            controller: this.tabController,
            tabs: <Widget>[
              Tab(
                text: "动态",
              ),
              Tab(
                text: "作品",
              ),
            ],
          ),
          Divider(
            height: 1,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      true; // 如果内容需要更新，设置为true
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
              height: ScreenUtil().setHeight(155),
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

//动态列表
class DynamicList extends StatelessWidget {
  const DynamicList({Key key}) : super(key: key);
  static Color slRandomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
    if (r == 0 || g == 0 || b == 0) return Colors.black;
    if (a == 0) return Colors.white;
    return Color.fromARGB(
      a,
      r != 255 ? r : Random.secure().nextInt(r),
      g != 255 ? g : Random.secure().nextInt(g),
      b != 255 ? b : Random.secure().nextInt(b),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: slRandomColor(),
      // child: ListView.builder(
      //   shrinkWrap: true,
      //   physics: ClampingScrollPhysics(),
      //   itemBuilder: (context, index) {
      //     return Container(
      //       color: slRandomColor(),
      //     );
      //   },
      //   itemExtent: ScreenUtil().setHeight(375),
      //   itemCount: 20,
      // ),
    );
  }
}

//作品列表
class WorksList extends StatelessWidget {
  const WorksList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: slRandomColor(),
      // child: ListView.builder(
      //   shrinkWrap: true,
      //   physics: ClampingScrollPhysics(),
      //   itemBuilder: (context, index) {
      //     return Container(
      //       color: slRandomColor(),
      //     );
      //   },
      //   itemExtent: ScreenUtil().setHeight(375),
      //   itemCount: 20,
      // ),
    );
  }
}
