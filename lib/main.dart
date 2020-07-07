import 'package:flutter/material.dart';
import 'package:monment/pages/index_page.dart';
import 'package:monment/provide/display_provide.dart';
import 'package:monment/provide/index_provide.dart';
import 'package:monment/provide/personal_home_provide.dart';
import 'package:monment/provide/ucenter_provide.dart';
import 'package:monment/routers/application.dart';
import 'package:fluro/fluro.dart';
import 'package:monment/routers/routes.dart';
import 'package:provide/provide.dart';
import 'package:flutter/services.dart';

void main() {
  //路由管理
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  //状态管理
  var providers = Providers();

  var indexProvide = IndexProvide();
  var displayProvide = DisplayProvide();
  var personalHomeProvide = PersonalHomeProvide();
  var ucenterProvide = UcenterProvide();

  providers
    ..provide(Provider<PersonalHomeProvide>.value(personalHomeProvide))
    ..provide(Provider<DisplayProvide>.value(displayProvide))
    ..provide(Provider<UcenterProvide>.value(ucenterProvide))
    ..provide(Provider<IndexProvide>.value(indexProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  //final SystemUiOverlayStyle _style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(_style);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      title: 'Monment',
      theme: ThemeData(
        highlightColor: Colors.white,
        splashColor: Colors.white,
      ),
      home: IndexPage(),
    );
  }
}
