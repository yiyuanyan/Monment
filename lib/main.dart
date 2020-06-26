import 'package:flutter/material.dart';
import 'package:monment/pages/index_page.dart';
import 'package:monment/provide/index_provide.dart';
import 'package:monment/routers/application.dart';
import 'package:fluro/fluro.dart';
import 'package:monment/routers/routes.dart';
import 'package:provide/provide.dart';

void main() {
  //路由管理
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;


  //状态管理
  var providers = Providers();

  var indexProvide = IndexProvide();


  providers
    ..provide(Provider<IndexProvide>.value(indexProvide));

  
  runApp(ProviderNode(child: MyApp(), providers: providers));
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


