import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monment/routers/router_handler.dart';

class Routes{
  static String root = "/";
  static String display = "/display";
  static String personalHome = "/personalHome";
  static void configureRoutes(Router router){
    //判断是否匹配到路由
    router.notFoundHandler = Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print("没有匹配到相应路由");
      }
    );
    router.define(root, handler: RootHandler);
    router.define(display, handler: DisplayHandler);
    router.define(personalHome, handler: PersonalHomeHandler);
  }
}