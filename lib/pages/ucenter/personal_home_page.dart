import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/routers/application.dart';
class PersonalHomePage extends StatefulWidget {
  final String userId;

  const PersonalHomePage({Key key, @required this.userId}) : super(key: key);
  @override
  _PersonalHomePageState createState() => _PersonalHomePageState();
}

class _PersonalHomePageState extends State<PersonalHomePage> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (result){
        //print(result.position.dy);

//        if(result.position.dy == 290){
//          setState(() {
//            titleWidget(1);
//          });
//        }
      },
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.more_vert), onPressed: (){
                print("点击了分享按钮");
              }),
            ],
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
              Application.router.pop(context);
            }),
            expandedHeight: ScreenUtil().setHeight(300),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints){
                double opa = (90 - constraints.biggest.height) * 0.1;

                if(opa > 0){
                  opa = opa;
                }else{
                  opa = 0;
                }
                print(opa);
                return FlexibleSpaceBar(
                  background: SliverTopBar(),
                  title: titleWidget(opa),
                  centerTitle: true,
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index){

              return Container(
                height: ScreenUtil().setHeight(30),
                color: Colors.blue,
              );
            },childCount: 30,),

          ),
        ],
      ),
    );
  }
  Widget titleWidget(double opa){
    return Opacity(
      opacity: opa != null ? opa : 0,
      child: Text(
        "我的首页",
        style: TextStyle(
          fontSize: ScreenUtil().setSp(18),
          color: Colors.black54,
        ),
      ),
    );
  }
}
class SliverTopBar extends StatelessWidget {
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
              color: Colors.purple,
            ),
            Divider(
              height: 1,
              color: Colors.grey[600],
            ),
            //切换按钮
            Container(
              height: ScreenUtil().setHeight(47),
              color: Colors.red,
            ),
            Divider(
              height: 1,
              color: Colors.grey[600],
            ),
          ],
        ),
        Positioned(
          top: ScreenUtil().setHeight(130),
          left: ScreenUtil().setWidth(30),
          child: Container(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/content/u167.png",),
            ),
          ),
        ),
      ],
    );
  }
}

