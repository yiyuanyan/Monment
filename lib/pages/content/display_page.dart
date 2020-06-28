//内容显示页面
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monment/routers/application.dart';

class DisplayPage extends StatelessWidget {
  final displayId;

  const DisplayPage({Key key, @required this.displayId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//        leading: IconButton(
//          onPressed: (){
//            Application.router.pop(context);
//          },
//          icon: Icon(Icons.arrow_back),
//          color: Colors.black,
//        ),
//      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              color: Colors.yellowAccent,
              child: Center(
                child: Text(this.displayId.toString()),
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Application.router.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),

          ),
        ],
      ),
    );
  }
}
