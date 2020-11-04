import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:idonelist/Presenter/add_task_presenter.dart';
import 'package:idonelist/Widget/align_calendar_container.dart';
import 'package:idonelist/Widget/constants.dart';
import 'package:idonelist/Widget/container_partten.dart';
import 'package:idonelist/Widget/container_tag.dart';
import 'package:idonelist/Widget/container_text.dart';
import 'package:idonelist/Widget/title_widget.dart';
import 'package:table_calendar/table_calendar.dart';


class AddTask extends StatefulWidget {
  AddTask({Key key, this.lenght}) : super(key: key);
  final int lenght;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<AddTask> with TickerProviderStateMixin {
  DateTime atualDate = DateTime.now();
  CalendarController _calendarController;
  AddTaskPresenter addTaskPresenter = new AddTaskPresenter();
  final _ctrlAddDone = TextEditingController();

  initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: Contants.idAppAdmob);

    if(widget.lenght == 2 || widget.lenght == 5 || widget.lenght == 9){
      addTaskPresenter.interstitialAd = addTaskPresenter.createInterstitialAd()..load();
    }

    addTaskPresenter.time = TimeOfDay.now();
    final _selectedDay = DateTime.now();
    addTaskPresenter.timeSele = addTaskPresenter.time.hour.toString()+':'+addTaskPresenter.time.minute.toString();

    addTaskPresenter.events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],

    };
    addTaskPresenter.selectedEvents = addTaskPresenter.events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    BackButtonInterceptor.add(myInterceptor);

  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
      addTaskPresenter.navegarHomePage(context);
      return true;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    addTaskPresenter.interstitialAd?.dispose();
    super.dispose();
  }


  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      addTaskPresenter.selectedEvents = events;
      atualDate = day;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }



  _pickTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: addTaskPresenter.time,

    );
    if(t != null)
      setState(() {
        addTaskPresenter.time = t;
        addTaskPresenter.timeSele = addTaskPresenter.time.hour.toString()+':'+addTaskPresenter.time.minute.toString();
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Contants.backgroundColor,
      body:Stack(
        children: <Widget>[
          Container(
            decoration: Contants.decorationBackground,
            width: MediaQuery
                .of(context)
                .size
                .width ,
            height: MediaQuery
                .of(context)
                .size
                .height ,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TitleWidget(title:"I done list"),
              AlignCalendarContainer(widget: _buildTableCalendar(),),
            ],
          ),
          Positioned(
              right:0,
              left:0,
              top:MediaQuery
                  .of(context)
                  .size
                  .height / 4,
              child:Hero(
                  tag:'add',
                  child:ContainerPartten(
                  widget:   Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery
                                  .of(context)
                                  .size.height / 40,left: MediaQuery
                              .of(context)
                              .size.height / 80,right: MediaQuery
                              .of(context)
                              .size.height / 100
                          ),

                          child:  Container(

                            width: MediaQuery
                                .of(context)
                                .size.width/1.1,
                            padding: EdgeInsets.only(
                                left: 16,  bottom: 4
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                              ),
                            ),
                            child: TextField(
                              controller: _ctrlAddDone,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              style: new TextStyle(color:   Contants.textColor,fontSize:MediaQuery.of(context).size.height/Contants.fontSize,fontFamily: Contants.fontFamily,),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add you done task',
                                hintStyle: new TextStyle(color:  Contants.textColor, fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.height/Contants.fontSize,fontFamily: Contants.fontFamily,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery
                                  .of(context)
                                  .size.height / 60,bottom: MediaQuery
                              .of(context)
                              .size
                              .height / 90,left: 16,right: MediaQuery
                              .of(context)
                              .size.height / 100
                          ),

                          child:  Container(
                            width: MediaQuery
                                .of(context)
                                .size.width/1.1,
                            height: 1,
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 4
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(0)
                              ),
                              color:  Contants.textColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                      ContainerText(title:"Add time",
                                    color:Contants.textColor),
                      GestureDetector(
                        onTap: (){
                          _pickTime();
                        },
                        child:ContainerText(title:addTaskPresenter.timeSele+'h',
                                            color: Contants.backgroundColor,)
                      ),
                      ContainerText(title:"Add tag",
                                    color:Contants.textColor),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  addTaskPresenter.redbool = true;
                                  addTaskPresenter.bluebool = false;
                                  addTaskPresenter.greenbool = false;
                                  addTaskPresenter.blackbool = false;
                                  addTaskPresenter.pinkbool = false;
                                  addTaskPresenter.yellowbool = false;
                                });
                              },
                              child:ContainerTag(color:Colors.red,background:addTaskPresenter.redbool),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  addTaskPresenter.redbool = false;
                                  addTaskPresenter.bluebool = true;
                                  addTaskPresenter.greenbool = false;
                                  addTaskPresenter.blackbool = false;
                                  addTaskPresenter.pinkbool = false;
                                  addTaskPresenter.yellowbool = false;
                                });
                              },
                              child:ContainerTag(color:Colors.blue,background:addTaskPresenter.bluebool),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  addTaskPresenter.redbool = false;
                                  addTaskPresenter.bluebool = false;
                                  addTaskPresenter.greenbool = true;
                                  addTaskPresenter.blackbool = false;
                                  addTaskPresenter.pinkbool = false;
                                  addTaskPresenter.yellowbool = false;
                                });
                              },
                              child:ContainerTag(color:Colors.green,background:addTaskPresenter.greenbool),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  addTaskPresenter.redbool = false;
                                  addTaskPresenter.bluebool = false;
                                  addTaskPresenter.greenbool = false;
                                  addTaskPresenter.blackbool = true;
                                  addTaskPresenter. pinkbool = false;
                                  addTaskPresenter. yellowbool = false;
                                });
                              },
                              child:ContainerTag(color:Colors.grey,background:addTaskPresenter.blackbool),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  addTaskPresenter.redbool = false;
                                  addTaskPresenter.bluebool = false;
                                  addTaskPresenter.greenbool = false;
                                  addTaskPresenter.blackbool = false;
                                  addTaskPresenter.pinkbool = true;
                                  addTaskPresenter.yellowbool = false;
                                });
                              },
                              child: ContainerTag(color:Colors.pink,background:addTaskPresenter.pinkbool),
                            ),

                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    addTaskPresenter.redbool = false;
                                    addTaskPresenter. bluebool = false;
                                    addTaskPresenter. greenbool = false;
                                    addTaskPresenter. blackbool = false;
                                    addTaskPresenter. pinkbool = false;
                                    addTaskPresenter.  yellowbool = true;
                                  });
                                },
                                child:Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:  EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: ContainerTag(color:Colors.yellow,background:addTaskPresenter.yellowbool),
                                    )
                                )
                            ),
                          ]
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:  EdgeInsets.only(
                                right: 30,left:30,top:MediaQuery
                                .of(context)
                                .size
                                .height / 7,bottom:10
                            ),
                            child:ButtonTheme(
                              minWidth:  MediaQuery.of(context).size.width,
                              height: 50,

                              child: RaisedButton(
                                onPressed: () => {
                                  addTaskPresenter.addDone(doneTask: _ctrlAddDone.text,context: context)
                                },
                                shape: new RoundedRectangleBorder(borderRadius:
                                new BorderRadius.circular(30.0)),
                                child: Text(
                                  "Add done task",
                                  style: TextStyle(fontFamily:Contants.fontFamily,color: Colors.white, fontSize:MediaQuery.of(context).size.height/Contants.fontSize),
                                ), //Text
                                color:Contants.backgroundColor,
                              ),//RaisedButton
                            ),//ButtonTheme
                          )
                      )

                    ],
                  ),
                      height: MediaQuery
                      .of(context)
                      .size
                      .height ,
                      width:  50
                  )

              )
          )

        ],
      ) ,
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: addTaskPresenter.events,
      headerVisible: false,
      initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(
          fontFamily: Contants.fontFamily,
          fontWeight: FontWeight.bold,
          color:  Color(0xFFffffff),
          fontSize:  MediaQuery.of(context).size.height/Contants.fontSize,
        ),
        weekendStyle: TextStyle(
          fontFamily: Contants.fontFamily,
          fontWeight: FontWeight.bold,
          color:  Color(0xFFffffff),
          fontSize:  MediaQuery.of(context).size.height/Contants.fontSize,
        ),
        outsideHolidayStyle:  TextStyle(
          fontFamily:Contants.fontFamily,
          fontWeight: FontWeight.bold,
          color:  Color(0xFFffffff),
          fontSize:  MediaQuery.of(context).size.height/Contants.fontSize,
        ),
        selectedColor:Colors.blue.withOpacity(0.3),
        todayColor:Colors.blue.withOpacity(0.1),
        markersColor: Contants.backgroundColor.withOpacity(0.3),
        outsideDaysVisible: false,
      ),

      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }
}
