import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonelist/AddTask.dart';
import 'package:idonelist/ListTask.dart';
import 'package:idonelist/Particles/Particles.dart';
import 'package:table_calendar/table_calendar.dart';
class HomePage extends StatelessWidget {
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

final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
   final Color backgroundColor = Color(0xFFB7B3FC);

  final Color sombraColor = Color(0xFFC6A2F8);
  var listMessage;
  String hora = '12h';
  String title = 'Tarefas';

  DateTime atualDate = DateTime.now();

  String dataSelected;


  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;


  @override
  void initState() {
    super.initState();

    List<String> date = atualDate.toString().split(' ');
    dataSelected = date[0];
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],

    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
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
      List<String> date = day.toString().split(' ');
      dataSelected = date[0];
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  void _incrementCounter() {


      Navigator.pushReplacement(
        context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => AddTask()),
      );

  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
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

            child:  Column(
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
                        color:  Color(0xFFfff9f9),
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
                        .height / 40
                    ),

                    child: _buildTableCalendar()
                  ),
                ),

                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height/1.4,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width/1.1 ,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: sombraColor,
                        blurRadius: 3.0, // has the effect of softening the shadow
                        spreadRadius: 3.0, // has the effect of extending the shadow
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                          'imagens/fundo.jpg'),
                      fit: BoxFit.fill,
                    ),

                    borderRadius: BorderRadius.all(
                        Radius.circular(20)
                    ),
                    gradient: LinearGradient(
                      begin:Alignment.topLeft,
                      end:Alignment.bottomRight,
                      colors: [
                        Color(0xFFf5f5f5),
                        Color(0xFFf5f5f5),
                      ],
                    ),

                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      buildListMessage()


                    ],
                  ),
                )

              ],
            ),
          ),

          Container(
            width: 20.0,
            height: MediaQuery
                .of(context)
                .size
                .height,

            child: DragTarget(
              builder:
                  (context, List<int> candidateData, rejectedData) {
                print(candidateData);
                return Center(child: Text("", style: TextStyle(color: Colors.white, fontSize: 22.0),));
              },
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {
                if(data == 1){
                  print('dragg');


                  setState(() {
                    hora = ' ';
                    title = '';
                  });
                }
              },
            ),
          ),
          Positioned(

            right: 10,
            top:MediaQuery
                .of(context)
                .size
                .height / 1.15,
            child:Hero(
              tag:'add',
              child:GestureDetector(
                  onTap: (){
                    _incrementCounter();
                  },
                  child:Container(
                    height: 50,
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
                          Radius.circular(10)
                      ),
                      gradient: LinearGradient(
                        begin:Alignment.topLeft,
                        end:Alignment.bottomRight,
                        colors: [
                          Colors.blue,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child:Icon(Icons.add),
                  )
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
      holidays: _holidays,
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

  Widget buildListMessage() {
    return Flexible(
      child: hora == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(backgroundColor)))
          : StreamBuilder(
        stream: Firestore.instance
            .collection('task')
            .document('1')
            .collection(dataSelected)
            .orderBy('timestamp', descending: false)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(backgroundColor)));
          } else {
            listMessage = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => ListTask(index, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,


            );
          }
        },
      ),
    );
  }
}




