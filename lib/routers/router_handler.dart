import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:monment/pages/index_page.dart';

var RootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return IndexPage();
  }
);