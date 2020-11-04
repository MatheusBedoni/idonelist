import 'package:flutter/material.dart';

class AlignCalendarContainer extends StatelessWidget {
  final Widget widget;


  AlignCalendarContainer({this.widget});

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
              .height / 40
          ),

          child: widget
      ),
    )
    ;
  }

}