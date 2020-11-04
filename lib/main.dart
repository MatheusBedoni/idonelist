import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idonelist/View/home_page.dart';
import 'package:idonelist/Widget/constants.dart';
import 'package:idonelist/Widget/container_text.dart';
import 'package:idonelist/Widget/title_widget.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IdoneList',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'IdoneList'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          navigateAfterSeconds: HomePage(),
          loaderColor: Colors.transparent,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: Contants.decorationBackground,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: SvgPicture.asset(
                    'imagens/check.svg',
                    width: 111,
                    height: 30,
                    fit: BoxFit.fill
                )
            ),
           

          ],
        )
      ],
    );
  }
}
