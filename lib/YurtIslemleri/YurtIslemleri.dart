import 'package:flutter/material.dart';
import 'package:flutter_application_3/Options/appbarContainer.dart';
import 'package:flutter_application_3/Options/backgroundimage.dart';
import 'package:flutter_application_3/Options/baslikContainer.dart';
import 'package:flutter_application_3/Options/buttons.dart';
import 'package:flutter_application_3/YurtIslemleri/katlar.dart';
import 'package:flutter_application_3/YurtIslemleri/temsilciler.dart';
import 'package:flutter_application_3/YurtIslemleri/yurtariza.dart';

class YurtIslemleriPage extends StatefulWidget {
  const YurtIslemleriPage({Key key}) : super(key: key);

  @override
  State<YurtIslemleriPage> createState() => _YurtIslemleriPageState();
}

class _YurtIslemleriPageState extends State<YurtIslemleriPage> {
  @override
  Widget build(BuildContext context) {
    background _background = background();
    Size size = MediaQuery.of(context).size;
    int _currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appbarContainer(),
        title: baslikTitle(),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background.image,
            fit: BoxFit.cover,
          ),
        ),
        width: size.width * 1,
        height: size.height * 1,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.only(top: 40),
            child: baslikContainer(title: "Yurt İşlemleri", size: 25),
          ),
          buttons(
            size: size * 1.2,
            page: KatlarPage(),
            title: "Kat Planları",
          ),
          buttons(
            size: size * 1.2,
            page: TemsilcilerPage(),
            title: "Temsilciler",
          ),
          buttons(
            size: size * 1.2,
            page: YurtArizaPage(),
            title: "Yurt Arıza Bildirimi",
          ),
        ]),
      ),
    );
  }
}
