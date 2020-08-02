import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListTask extends StatelessWidget{
 final int index;
 final DocumentSnapshot document;
  ListTask(this.index,this.document);
  @override
  Widget build(BuildContext context) {
    return  Draggable(
      data: 1,
      child:Row(
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
                  color:document['tag'] == 'red'? Colors.red: document['tag'] == 'blue' ?Colors.blue: document['tag'] == 'black' ?Colors.grey: document['tag'] == 'green' ?Colors.green: document['tag'] == 'pink' ?Colors.pink: document['tag'] == 'yellow' ?Colors.yellow:Colors.white,
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

              child: Text(document['hora']+'h',
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
                    child:Text(document['title'],
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
      ) ,
      feedback: Row(
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
                  .height / 25
              ),

              child: Text("*",
                style: TextStyle(
                  fontFamily: 'JosefinSlab',
                  color:  Colors.red,
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
                      .height / 50,top: MediaQuery
                  .of(context)
                  .size
                  .height / 25
              ),

              child: Text(document['hora'],
                style: TextStyle(
                  decorationStyle: TextDecorationStyle.wavy,
                  fontFamily: 'JosefinSlab',
                  color:  Color(0xFF707070),
                  fontSize:  MediaQuery.of(context).size.height/55,
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
                          .height / 50,top: MediaQuery
                      .of(context)
                      .size
                      .height / 25
                  ),

                  child: Text(document['title'],
                    style: TextStyle(
                      decorationStyle: TextDecorationStyle.wavy,
                      fontFamily: 'JosefinSlab',
                      fontWeight: FontWeight.bold,
                      color:  Color(0xFF707070),
                      fontSize:  MediaQuery.of(context).size.height/35,
                    ),
                  ),
                ),
              ),


            ],
          ),

        ],
      ) ,
      childWhenDragging: Container(),
    )
    ;

  }


}