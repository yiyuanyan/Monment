import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/provide/personal_home_provide.dart';
import 'package:monment/routers/application.dart';
import 'package:provide/provide.dart';

class PersonalHomePage extends StatefulWidget {
  final userId;
  PersonalHomePage({Key key, @required this.userId}) : super(key: key);

  @override
  _PersonalHomePageState createState() => _PersonalHomePageState();
}

class _PersonalHomePageState extends State<PersonalHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;
  double opa = 0;
  Color cusColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
    this.scrollController = ScrollController();
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
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            expandedHeight: ScreenUtil().setHeight(225),
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
              centerTitle: true,
              title: homeTitle(opa),
              background: SliverTopBar(),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: '动态'),
                  Tab(text: '作品'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
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

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

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
            Divider(
              height: 1,
              color: Colors.grey[300],
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
