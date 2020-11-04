import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonelist/Model/task.dart';
import 'package:idonelist/funcoes_extras.dart';

class ListTask extends StatelessWidget{
 final int index;
 final Task document;
  ListTask({this.index,this.document});
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery
                    .of(context)
                    .size
                    .height / 50,top: MediaQuery
                .of(context)
                .size
                .height / 20
            ),

            child: Text("*",
              style: TextStyle(
                fontFamily: 'JosefinSlab',
                color:Extras.getNoNullText(document.tag) == 'red'? Colors.red: Extras.getNoNullText(document.tag)== 'blue' ?Colors.blue: Extras.getNoNullText(document.tag) == 'black' ?Colors.grey: Extras.getNoNullText(document.tag) == 'green' ?Colors.green: Extras.getNoNullText(document.tag) == 'pink' ?Colors.pink: Extras.getNoNullText(document.tag) == 'yellow' ?Colors.yellow:Colors.white,
                fontSize:  MediaQuery.of(context).size.height/45,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery
                    .of(context)
                    .size
                    .height / 70,top: MediaQuery
                .of(context)
                .size
                .height / 25
            ),

            child: Text(Extras.getNoNullText(document.hora+'h'),
              style: TextStyle(
                fontFamily: 'JosefinSlab',
                color:  Color(0xFF707070),
                fontSize:  MediaQuery.of(context).size.height/38,
              ),
            ),
          ),
        ),


        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery
                          .of(context)
                          .size
                          .height / 80,top: MediaQuery
                      .of(context)
                      .size
                      .height / 25
                  ),

                  child:Container(
                    width:MediaQuery.of(context).size.width/1.7 ,
                    child:Text(Extras.getNoNullText(document.title),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,

                      style: TextStyle(
                        decorationStyle: TextDecorationStyle.wavy,
                        fontFamily: 'JosefinSlab',
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFF707070),
                        fontSize:  MediaQuery.of(context).size.height/45,
                      ),
                    ),
                  )
              ),
            ),


          ],
        ),

      ],
    )
    ;

  }


}