import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/pages/release/release_page.dart';
import 'home/home_page.dart';
import 'channel/channel_page.dart';
import 'dynamic/dynamic_page.dart';
import 'ucenter/ucenter_page.dart';
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: false);
    ScreenUtil.init(context);
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: false);
    return IndexWidgets();
  }
}

class IndexWidgets extends StatefulWidget {
  @override
  _IndexWidgetsState createState() => _IndexWidgetsState();
}

class _IndexWidgetsState extends State<IndexWidgets> {
  final List<Widget> tabBodies = [
    HomePage(),
    ChannelPage(),
    //ReleasePage(),
    DynamicPage(),
    UcenterPage(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("点击了拍照按钮");
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _customBottomItem(currentIndex, 0, "assets/images/bottom/u198.png", "首页"),
            _customBottomItem(currentIndex, 1, "assets/images/bottom/u201.png", "频道"),
            _customBottomItem(currentIndex, -1, null, "发现"),
            _customBottomItem(currentIndex, 2, "assets/images/bottom/u207.png", "动态"),
            _customBottomItem(currentIndex, 3, "assets/images/bottom/u210.png", "我的"),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
  //自定义底部按钮
  Widget _customBottomItem(int selectIndex, int index, String iconPath, String title){
    //未选中样式
    TextStyle textStyle = TextStyle(fontSize: ScreenUtil().setSp(12), color: Colors.grey);
    MaterialColor iconColor = Colors.grey;
    double iconSize = ScreenUtil().setSp(24);
    EdgeInsetsGeometry padding = EdgeInsets.only(top: ScreenUtil().setWidth(8));
    if(selectIndex == index){
      //选中状态的文字样式
      textStyle = TextStyle(fontSize: ScreenUtil().setSp(12), color: Colors.blue);
      //选中状态的按钮样式
      iconColor = Colors.blue;
      iconSize = ScreenUtil().setSp(24);
      padding = EdgeInsets.only(top: ScreenUtil().setHeight(8));
    }
    Widget padItem = SizedBox();
    if(iconPath != null){
      padItem = Padding(
        padding: padding,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                ImageIcon(
                  AssetImage(iconPath),
                  color: iconColor,
                  size: iconSize,
                ),
                Text(
                  title,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      );
    }
    Widget item = Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: (){
          if(index != currentIndex){
            setState(() {
              currentIndex = index;
            });
          }

        },
        child: SizedBox(
          height: ScreenUtil().setHeight(60),
          child: padItem,
        ),
      ),
    );
    return item;
  }
}



