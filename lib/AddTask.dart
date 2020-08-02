import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonelist/HomePage.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTask extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I done list',
      theme: ThemeData(


        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'I done list Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  final Color backgroundColor = Color(0xFFB7B3FC);



  bool redbool = false;
  bool blackbool = false;
  bool bluebool = false;
  bool greenbool = false;
  bool pinkbool = false;
  bool yellowbool = false;
  TimeOfDay time;
  String timeSele = '00:00h';

  DateTime atualDate = DateTime.now();


  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  final Color sombraColor = Color(0xFFC6A2F8);

  final _ctrlAddDone = TextEditingController();

  void _incrementCounter() {
    List<String> date = atualDate.toString().split(' ');
    print(date[0]);
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

    var documentReference = Firestore.instance
        .collection('task')
        .document('1')
        .collection(date[0])
        .document(DateTime.now().millisecondsSinceEpoch.toString());

    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {
          'title':_ctrlAddDone.text,
          'hora': timeSele,
          'tag':tag,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),

        },
      );
    });
    Navigator.pushReplacement(
      context, PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => HomePage()),
    );

  }

  initState() {
    super.initState();
    time = TimeOfDay.now();
    final _selectedDay = DateTime.now();
    timeSele = time.hour.toString()+':'+time.minute.toString();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],

    };
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }


  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
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
        initialTime: time
    );
    if(t != null)
      setState(() {
        time = t;
        timeSele = time.hour.toString()+':'+time.minute.toString();
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body:Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(

              gradient: LinearGradient(

                colors: [
                  backgroundColor,
                  backgroundColor.withOpacity(0.6),
                ],
              ),

            ),
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
                      .height / 15,bottom:  MediaQuery
                      .of(context)
                      .size
                      .height / 50
                  ),

                  child: Text("I done list",
                    style: TextStyle(
                      fontFamily: 'JosefinSlab',
                      fontWeight: FontWeight.bold,
                      color:  Color(0xFFffffff),
                      fontSize:  MediaQuery.of(context).size.height/30,
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
                      .height / 40,bottom:  MediaQuery
                      .of(context)
                      .size
                      .height / 50
                  ),

                  child:  _buildTableCalendar()
                ),
              ),



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
                  child:Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height ,
                        width: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: sombraColor,
                              blurRadius: 3.0, // has the effect of softening the shadow
                              spreadRadius: 3.0, // has the effect of extending the shadow
                            )
                          ],
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)
                          ),
                          gradient: LinearGradient(
                            begin:Alignment.topLeft,
                            end:Alignment.bottomRight,
                            colors: [
                              Color(0xFFfff9f9),
                              Color(0xFFFFFAFA),
                            ],
                          ),
                        ),
                        child:Column(
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

                                    style: new TextStyle(color:   Color(0xFF707070),fontSize:MediaQuery.of(context).size.height/35,fontFamily: 'JosefinSlab',),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Add you done task',
                                      hintStyle: new TextStyle(color: Color(0xFF707070), fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.height/35,fontFamily: 'JosefinSlab',),
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
                                    color:  Color(0xFF707070).withOpacity(0.8),
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

                                child: Text("Add time",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'JosefinSlab',
                                    color:  Color(0xFF707070),
                                    fontSize:  MediaQuery.of(context).size.height/35,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _pickTime();
                              },
                              child: Align(
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

                                  child: Text(timeSele+'h',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'JosefinSlab',
                                      color:  backgroundColor,
                                      fontSize:  MediaQuery.of(context).size.height/35,
                                    ),
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

                                child: Text("Add tag",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'JosefinSlab',
                                    color:  Color(0xFF707070),
                                    fontSize:  MediaQuery.of(context).size.height/35,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        redbool = true;
                                        bluebool = false;
                                        greenbool = false;
                                        blackbool = false;
                                        pinkbool = false;
                                        yellowbool = false;
                                      });
                                    },
                                    child:containerTag(Colors.red,redbool),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        redbool = false;
                                        bluebool = true;
                                        greenbool = false;
                                        blackbool = false;
                                        pinkbool = false;
                                        yellowbool = false;
                                      });
                                    },
                                    child:containerTag(Colors.blue,bluebool),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        redbool = false;
                                        bluebool = false;
                                        greenbool = true;
                                        blackbool = false;
                                        pinkbool = false;
                                        yellowbool = false;
                                      });
                                    },
                                    child:containerTag(Colors.green,greenbool),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        redbool = false;
                                        bluebool = false;
                                        greenbool = false;
                                        blackbool = true;
                                        pinkbool = false;
                                        yellowbool = false;
                                      });
                                    },
                                    child:containerTag(Colors.grey,blackbool),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        redbool = false;
                                        bluebool = false;
                                        greenbool = false;
                                        blackbool = false;
                                        pinkbool = true;
                                        yellowbool = false;
                                      });
                                    },
                                    child: containerTag(Colors.pink,pinkbool),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        redbool = false;
                                        bluebool = false;
                                        greenbool = false;
                                        blackbool = false;
                                        pinkbool = false;
                                        yellowbool = true;
                                      });
                                    },
                                    child:Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding:  EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: containerTag(Colors.yellow,yellowbool),
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
                                  child:       ButtonTheme(
                                    minWidth:  MediaQuery.of(context).size.width,
                                    height: 50,

                                    child: RaisedButton(
                                      onPressed: () => { _incrementCounter() },
                                      shape: new RoundedRectangleBorder(borderRadius:
                                      new BorderRadius.circular(30.0)),
                                      child: Text(
                                        "Add done task",
                                        style: TextStyle(fontFamily: 'JosefinSlab',color: Colors.white, fontSize:MediaQuery.of(context).size.height/35),
                                      ), //Text
                                      color:backgroundColor,
                                    ),//RaisedButton
                                  ),//ButtonTheme
                                )
                            )

                          ],
                        ),
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
      events: _events,
      headerVisible: false,
      initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(
          fontFamily: 'JosefinSlab',
          fontWeight: FontWeight.bold,
          color:  Color(0xFFffffff),
          fontSize:  MediaQuery.of(context).size.height/35,
        ),
        weekendStyle: TextStyle(
          fontFamily: 'JosefinSlab',
          fontWeight: FontWeight.bold,
          color:  Color(0xFFffffff),
          fontSize:  MediaQuery.of(context).size.height/35,
        ),
        outsideHolidayStyle:  TextStyle(
          fontFamily: 'JosefinSlab',
          fontWeight: FontWeight.bold,
          color:  Color(0xFFffffff),
          fontSize:  MediaQuery.of(context).size.height/35,
        ),
        selectedColor:Colors.blue.withOpacity(0.3),
        todayColor:Colors.blue.withOpacity(0.1),
        markersColor: backgroundColor.withOpacity(0.3),
        outsideDaysVisible: false,
      ),

      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }



  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }



  Widget containerTag(Color color,bool background){
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
                .height / 40,right:MediaQuery
                .of(context)
                .size
                .height / 40,top:MediaQuery
                .of(context)
                .size
                .height / 40,bottom:MediaQuery
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
                borderRadius: BorderRadius.all(
                    Radius.circular(45)
                )
            ),

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("*",
                    style: TextStyle(
                      fontFamily: 'JosefinSlab',
                      color:  color,
                      fontSize:  MediaQuery.of(context).size.height/45,
                    ),
                  ),
                ]
            )
        )
      ),
    );
  }
}
