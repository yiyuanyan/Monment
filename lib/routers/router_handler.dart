import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monment/pages/index_page.dart';
import '../pages/content/display_page.dart';
var RootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return IndexPage();
  }
);

var DisplayHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    String displayId = params["displayId"].first;
    return DisplayPage(displayId: displayId,);
  }
);