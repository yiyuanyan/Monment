import 'package:flutter/material.dart';
import 'package:monment/pages/index_page.dart';
import 'package:monment/routers/application.dart';
import 'package:fluro/fluro.dart';
import 'package:monment/routers/routes.dart';

void main() {
  //路由管理
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;


  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      title: 'Monment',
      theme: ThemeData(
        highlightColor: Colors.blue,
        splashColor: Colors.blue
      ),
      home: IndexPage(),
    );
  }
}


