import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonelist/Date.dart';

class ListTask extends StatelessWidget {
  final Date date;

  ListTask(this.date);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(date.dia,
          style: TextStyle(
            fontFamily: 'JosefinSlab',
            color: Color(0xFFffffff),
            fontSize: MediaQuery
                .of(context)
                .size
                .height / 45,
          ),
        ),
        Text(date.diaMes,
          style: TextStyle(
            fontFamily: 'JosefinSlab',
            fontWeight: FontWeight.bold,
            color: Color(0xFFffffff),
            fontSize: MediaQuery
                .of(context)
                .size
                .height / 45,
          ),
        ),
      ],
    )
    ;
  }

}