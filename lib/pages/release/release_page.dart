import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ReleasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("拍照"),
        ),
      ),
    );
  }
}
