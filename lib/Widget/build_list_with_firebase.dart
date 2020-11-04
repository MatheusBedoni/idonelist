import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonelist/Widget/list_task.dart';

import 'constants.dart';

class BuildListWithFirebase extends StatelessWidget {
  ///The idea is the code for used by other projects using firebase

  final String flag;
  final String nameCollectionOne;
  final String nameDocument;
  final String nameCollectionTwo;
  final String orderBy;
  BuildListWithFirebase({this.flag,this.nameCollectionOne,this.nameDocument,this.nameCollectionTwo,this.orderBy});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: flag == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Contants.backgroundColor)))
          : StreamBuilder(
        stream: Firestore.instance
            .collection(nameCollectionOne)
            .document(nameDocument)
            .collection(nameCollectionTwo)
            .orderBy(orderBy, descending: false)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Contants.backgroundColor)));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => ListTask(index:index,document: snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

}