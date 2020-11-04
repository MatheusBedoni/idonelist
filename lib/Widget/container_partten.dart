import 'package:flutter/material.dart';
import 'package:idonelist/Widget/constants.dart';

class ContainerPartten extends StatelessWidget {
  final Widget widget;
  final double height;
  final double width;

  ContainerPartten({this.widget,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width:width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Contants.sombraColor,
              blurRadius: 3.0,
              spreadRadius: 3.0,
            )
          ],
          image: DecorationImage(
            image: AssetImage(
                'imagens/fundo.jpg'),
            fit: BoxFit.fill,
          ),

          borderRadius: BorderRadius.all(
              Radius.circular(20)
          ),
          color: Colors.white

      ),

      child: widget,
    )
    ;
  }

}