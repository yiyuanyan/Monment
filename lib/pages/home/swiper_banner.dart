import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/config/service_url.dart';
import '../../model/home_model.dart';
class SwiperBanner extends StatelessWidget {
  final List<Swipers> swipers;

  const SwiperBanner({Key key, @required this.swipers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left:ScreenUtil().setHeight(8), top:ScreenUtil().setHeight(8),right:ScreenUtil().setHeight(8)),
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(180),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.all(Radius.circular(5)),
//        color: Colors.red,
//      ),
      child: Swiper(
        itemCount: 4,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 6.0,
            activeSize: 6.0,

          ),
        ),
        //loop: true,
        autoplay: true,
        controller: SwiperController(),
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              print("点击了ID为${this.swipers[index].id}的广告");
            },
            child: ConstrainedBox(
              child: Image.network(
                fileURL+this.swipers[index].banner,
                fit: BoxFit.fitWidth,
              ),
              constraints: BoxConstraints.expand(),
            ),
          );
        },
      ),
    );
  }
}
