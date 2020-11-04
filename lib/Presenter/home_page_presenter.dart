

import 'package:flutter/material.dart';
import 'package:idonelist/Model/database_helper.dart';
import 'package:idonelist/Model/task.dart';
import 'package:idonelist/View/add_task.dart';

class HomePageView {
  void consultarTask(String dataSelected) {}
  void navegarAddTask(BuildContext context,int tamanho) {}
}

class HomePagePresenter implements HomePageView {
  List<Task> listTasks = new List<Task>();
  final dbHelper = DatabaseHelper.instance;
  Map<DateTime, List> events;
  List selectedEvents;

  HomePagePresenter() {}

  /// Busca os dados no banco, baseado na data informada pelo user
  @override
  Future<List<Task>> consultarTask(String dataSelected) async {
    final allTasks = await dbHelper.query(dataSelected);
    listTasks = allTasks.map((model) => Task.fromMap(model)).toList();
    return listTasks;
  }

  /// Navega pra tela de adicionar task
  @override
  void navegarAddTask(BuildContext context,int tamanho) {
    Navigator.pushReplacement(
      context, PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 100),
        pageBuilder: (_, __, ___) => AddTask(lenght: tamanho,)),
    );
  }

}