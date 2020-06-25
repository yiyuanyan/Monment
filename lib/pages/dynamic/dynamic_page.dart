import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("动态", style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.grey[600]),),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Container(
        child: Center(
          child: Text("动态"),
        ),
      ),
    );
  }
}
