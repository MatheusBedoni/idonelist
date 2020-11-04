import 'package:flutter/material.dart';
import 'package:idonelist/Widget/constants.dart';

class ContainerText extends StatelessWidget {
  final String title;
  final Color color;

  ContainerText({this.title,this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery
                .of(context)
                .size
                .height / 50,top: MediaQuery
            .of(context)
            .size
            .height / 25
        ),

        child: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: Contants.fontFamily,
            color:  color,
            fontSize:  MediaQuery.of(context).size.height/ Contants.fontSize,
          ),
        ),
      ),
    );
  }

}