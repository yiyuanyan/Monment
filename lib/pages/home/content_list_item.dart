import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/routers/application.dart';
import '../../model/home_model.dart';
class ContentListItem extends StatelessWidget {
  final int id;
  final String image;
  final String playTime;
  final String portrait;
  final String title;
  final String tag;

  const ContentListItem({Key key, @required this.id, @required this.image, @required this.playTime, @required this.portrait, @required this.title, @required this.tag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("点击了ID为" +this.id.toString()+ "视频内容");
        Application.router.navigateTo(context, "/display?displayId="+this.id.toString());
      },
      child: Container(
        width: ScreenUtil().setWidth(335),
        height: ScreenUtil().setHeight(265),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(345),
                  height: ScreenUtil().setHeight(182),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: NetworkImage(this.image),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Positioned(
                  bottom: ScreenUtil().setHeight(20),
                  right: ScreenUtil().setWidth(10),
                  child: Container(
                    width: ScreenUtil().setWidth(47),
                    height: ScreenUtil().setHeight(24),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        this.playTime.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              height: ScreenUtil().setHeight(47),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: new Image.network(this.portrait),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        this.tag.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(24),
            ),
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
