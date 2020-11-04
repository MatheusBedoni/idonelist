import 'package:flutter/material.dart';
import 'package:idonelist/Widget/constants.dart';

class ContainerTag extends StatelessWidget {
  final Color color;
  final bool background;

  ContainerTag({this.color,this.background});

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

          child:Container(

              padding: EdgeInsets.only(
                  left: MediaQuery
                      .of(context)
                      .size
                      .height / 60,right:MediaQuery
                  .of(context)
                  .size
                  .height / 60,top:MediaQuery
                  .of(context)
                  .size
                  .height / 60,bottom:MediaQuery
                  .of(context)
                  .size
                  .height / 60
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      background == false?  Color(0xFFffffff): color,
                      background == false?  Color(0xFFffffff): color,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity( background == false ? 0.2: 0.7),
                      blurRadius: 3.0, // has the effect of softening the shadow
                      spreadRadius: 3.0, // has the effect of extending the shadow
                    )
                  ],
                  borderRadius: BorderRadius.all(
                      Radius.circular(45)
                  )
              ),

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("*",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily:Contants.fontFamily,
                        color:  color,
                        fontSize:  MediaQuery.of(context).size.height/30,
                      ),
                    ),
                  ]
              )
          )
      ),
    );
  }

}