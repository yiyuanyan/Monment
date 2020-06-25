import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwiperBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:ScreenUtil().setHeight(8), top:ScreenUtil().setHeight(8),right:ScreenUtil().setHeight(8)),
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.red,
      ),
      child: Swiper(
        itemCount: 4,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 6.0,
            activeSize: 6.0
          ),
        ),
        controller: SwiperController(),
        itemBuilder: (BuildContext context, int index){
          return InkWell();
        },
      ),
    );
  }
}
