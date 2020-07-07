import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:monment/provide/personal_home_provide.dart';
import 'package:monment/provide/ucenter_provide.dart';
import 'package:flutter_screenutil/screenutil.dart';
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
  final String uiser_id;
  PersonalHomePage({Key key, @required this.uiser_id}) : super(key: key);

  @override
  _PersonalHomePageState createState() => _PersonalHomePageState();
}

class _PersonalHomePageState extends State<PersonalHomePage>
    with SingleTickerProviderStateMixin {
  bool _show = true;
  //滚动控制器
  ScrollController scrollController;
  //Tab控制器
  TabController tabController;
  //折叠预拉伸时appbar文字和按钮的透明度
  double opa = 0;
  //折叠预拉伸时appbar文字和按钮的颜色
  Color cusColor;
  double top = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化控制器
    this.scrollController = ScrollController();
    //初始化控制器
    this.tabController = TabController(length: 2, vsync: this);
    //重点：给控制器增加滚动监听方法
  }

  @override
  Widget build(BuildContext context) {
    if (top == 80) {
      setState(() {
        cusColor = Colors.black;
        opa = 1;
        _show = false;
      });
    } else {
      setState(() {
        opa = 0;
        cusColor = Colors.white;
        _show = true;
      });
    }
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        controller: this.scrollController,
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            expandedHeight: Platform.isIOS == true
                ? ScreenUtil().setHeight(233)
                : ScreenUtil().setHeight(223),
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
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.biggest.height == 80) {
                  Provide.value<UcenterProvide>(context).changeOpa(1);
                } else {
                  Provide.value<UcenterProvide>(context).changeOpa(0);
                }

                return FlexibleSpaceBar(
                  title: homeTitle(0),
                  centerTitle: true,
                  background: SliverTopBar(),
                );
              },
            ),
          ),
          SliverPersistentHeader(
            //可折叠AppBar底部栏
            pinned: true, //是否可吸附
            //自定义代理并且将控制器传入
            delegate: MySliverPersistentHeaderDelegate(
                tabController: this.tabController),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: slRandomColor(),
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: slRandomColor(),
                child: new Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                ),
          ),
        ],
      ),
    );
  }

  void setOpa(double opa) {
    setState(() {
      this.opa = opa;
    });
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
