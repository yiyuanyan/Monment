import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/config/service_url.dart';
import 'package:monment/provide/index_provide.dart';
import 'package:provide/provide.dart';
import 'home/home_page.dart';
import '../model/home_model.dart';
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
    return FutureBuilder(
      future: _getIndexInfo(context),
      builder: (BuildContext context, snapshot){
        if(snapshot.data == "OK"){
          List<IconList> iconList = Provide.value<IndexProvide>(context).iconList;
          return IndexWidgets(iconList: iconList);
        }else{
          return Container(
            child: Center(
              child: Text("正在加载中...."),
            ),
          );
        }
      },
    );
  }
  Future<String> _getIndexInfo(BuildContext context) async{
    await Provide.value<IndexProvide>(context).getBottomBarIcons();
    int barIconsStatusCode = Provide.value<IndexProvide>(context).barIconsStatusCode;
    if(barIconsStatusCode == 200){
      return "OK";
    }else{
      return "false";
    }
  }
}

class IndexWidgets extends StatefulWidget {
  final List<IconList> iconList;
  const IndexWidgets({Key key, @required this.iconList,}) : super(key: key);
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

            _customBottomItem(currentIndex, 0, fileURL+widget.iconList[0].icon, "首页"),
            _customBottomItem(currentIndex, 1, fileURL+widget.iconList[1].icon, "频道"),
            _customBottomItem(currentIndex, -1, null, "发现"),
            _customBottomItem(currentIndex, 2, fileURL+widget.iconList[2].icon, "动态"),
            _customBottomItem(currentIndex, 3, fileURL+widget.iconList[3].icon, "我的"),
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
                  NetworkImage(iconPath),
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
          height: ScreenUtil().setHeight(67),
          child: padItem,
        ),
      ),
    );
    return item;
  }
}







