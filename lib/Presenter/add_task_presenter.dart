

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:idonelist/Model/database_helper.dart';
import 'package:idonelist/Model/task.dart';
import 'package:idonelist/View/home_page.dart';
import 'package:idonelist/Widget/constants.dart';

class AddTaskView {
  void insert({String task,String hour, String date, String tag}){}
  void navegarHomePage(BuildContext context) {}
  void addDone({String doneTask, BuildContext context }) {}
  InterstitialAd createInterstitialAd(){}
}

class AddTaskPresenter implements AddTaskView {
  List<Task> listTasks = new List<Task>();
  final dbHelper = DatabaseHelper.instance;
  Map<DateTime, List> events;
  List selectedEvents;


  InterstitialAd interstitialAd;

  //valores booleanos correspondentes as tags de tarefas
  bool redbool = false;
  bool blackbool = false;
  bool bluebool = false;
  bool greenbool = false;
  bool pinkbool = false;
  bool yellowbool = false;
  TimeOfDay time;
  String timeSele = '00:00h';

  AddTaskPresenter() {}

  /// Navega de volta pra tela HomePage
  @override
  void navegarHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context, PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => HomePage()),
    );
  }

  /// Inseri os dados da tarefa no banco
  @override
  Future<int> insert({String task, String hour, String date, String tag}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnTask : task,
      DatabaseHelper.columnHour  : hour,
      DatabaseHelper.columnDate  : date,
      DatabaseHelper.columnTag  : tag
    };
    final id = await dbHelper.insert(row);
    return id;
  }
  /// Cria um anuncio de de tela inteira no app
  @override
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: Contants.idIntersAdmob,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  /// Organiza os dados informados pelo usuario e depois salvar no banco
  @override
  Future<void> addDone({String doneTask, BuildContext context }) async {
    List<String> date =  DateTime.now().toString().split(' ');
    String tag;

    if(redbool == true){
      tag = 'red';
    }else if(blackbool == true){
      tag = 'black';
    }else if(bluebool == true){
      tag = 'blue';
    }else if(greenbool == true){
      tag = 'green';
    }else if(pinkbool == true){
      tag = 'pink';
    }else if(yellowbool == true){
      tag = 'yellow';
    }
    int id = await insert(tag: tag, task:doneTask, hour: timeSele,date: date[0]);

    if(id != null){
      interstitialAd?.show();
      navegarHomePage(context);
    }

  }


}