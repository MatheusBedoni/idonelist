import 'package:flutter/material.dart';
import 'package:idonelist/Model/task.dart';
import 'package:idonelist/Presenter/home_page_presenter.dart';
import 'package:idonelist/Widget/align_calendar_container.dart';
import 'package:idonelist/Widget/container_text.dart';
import 'package:idonelist/Widget/list_task.dart';
import 'package:idonelist/funcoes_extras.dart';
import 'package:idonelist/Widget/constants.dart';
import 'package:idonelist/Widget/container_partten.dart';
import 'package:idonelist/Widget/title_widget.dart';
import 'package:table_calendar/table_calendar.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with TickerProviderStateMixin {
  String dataSelected;

  CalendarController _calendarController;
  List<Task> listTasks = new List<Task>();

  HomePagePresenter homePagePresenter = new HomePagePresenter();

  @override
  void initState() {
    super.initState();
    List<String> date = DateTime.now().toString().split(' ');
    dataSelected = date[0];
    _consultar();
    homePagePresenter.events = {
      DateTime.now().subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
    };
    homePagePresenter.selectedEvents = homePagePresenter.events[DateTime.now()] ?? [];
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      homePagePresenter.selectedEvents = events;
      List<String> date = day.toString().split(' ');
      dataSelected = date[0];
      _consultar();
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  void _consultar() async {
    listTasks = await homePagePresenter.consultarTask(dataSelected) ;
    setState(() {
      listTasks = homePagePresenter.listTasks;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Stack(
        children: <Widget>[
          Container(
            decoration:Contants.decorationBackground,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TitleWidget(title:"I done list"),
                AlignCalendarContainer(widget: _buildTableCalendar(),),
                GestureDetector(
                  onTap: (){
                    homePagePresenter.navegarAddTask(context,listTasks.length);
                  },
                  child:Hero(
                      tag:'add',
                    child:ContainerPartten(
                        widget: this.listTasks.length > 0? ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_,int index)=>ListTask(document: this.listTasks[index], index:index),
                          itemCount: this.listTasks.length,
                        ) : Center(
                          child:ContainerText(title:"An app to keep the good things you did today!",
                              color:Contants.textColor),
                        ),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height/1.4,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width/1.1)
                  ) ,
                )

              ],
            ),
          ),

        ],
      ) ,
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: homePagePresenter.events,
      holidays: Extras.holidays,
      headerVisible: false,
      initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(
          fontFamily:Contants.fontFamily,
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
          fontFamily: Contants.fontFamily,
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




