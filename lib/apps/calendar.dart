import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:provider/provider.dart';
import '../sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final Offset initPos;
  const Calendar({this.initPos, Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Offset position = Offset(0.0, 0.0);
  bool calendarFS;
  bool calendarPan;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay= DateTime.utc(1999, 07, 10);
  DateTime focusedDay= DateTime.now();


  @override
  void initState() {
    position = widget.initPos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var spotifyOpen = Provider.of<OnOff>(context).getCalendar;
    calendarFS = Provider.of<OnOff>(context).getCalendarFS;
    calendarPan = Provider.of<OnOff>(context).getCalendarPan;
    return Visibility(
      visible: spotifyOpen,
          child: AnimatedPositioned(
      duration: Duration(milliseconds: calendarPan ? 0 : 200),
      top: calendarFS ? screenHeight(context, mulBy: 0.0335) : position.dy,
      left: calendarFS ? 0 : position.dx,
      child: calendarWindow(context),
    ),
        );
  }

  AnimatedContainer calendarWindow(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: calendarFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.7),
      height: calendarFS
          ? screenHeight(context, mulBy: 0.863)
          : screenHeight(context, mulBy: 0.75),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor.withOpacity(1),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: calendarFS
                    ? screenHeight(context, mulBy: 0.059)
                    : screenHeight(context, mulBy: 0.06),
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
              ),
              GestureDetector(
                onPanUpdate: (tapInfo) {
                  if (!calendarFS) {
                    setState(() {
                      position = Offset(position.dx + tapInfo.delta.dx,
                          position.dy + tapInfo.delta.dy);
                    });
                  }
                },
                onPanStart: (details) {
                  Provider.of<OnOff>(context, listen: false).onCalendarPan();
                },
                onPanEnd: (details) {
                  Provider.of<OnOff>(context, listen: false).offCalendarPan();
                },
                onDoubleTap: () {
                  Provider.of<OnOff>(context, listen: false).toggleCalendarFS();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  width: calendarFS
                      ? screenWidth(context, mulBy: 0.95)
                      : screenWidth(context, mulBy: 0.7),
                  height: calendarFS
                      ? screenHeight(context, mulBy: 0.059)
                      : screenHeight(context, mulBy: 0.06),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, mulBy: 0.013),
                    vertical: screenHeight(context, mulBy: 0.01)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                          onTap: () {
                            Provider.of<OnOff>(context, listen: false)
                                .toggleCalendar();
                            Provider.of<OnOff>(context, listen: false)
                                .offCalendarFS();
                          },
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.005),
                        ),
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.005),
                        ),
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                          onTap: () {
                            Provider.of<OnOff>(context, listen: false)
                                .toggleCalendarFS();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              ),
              child: Container(
                height: screenHeight(context, mulBy: 0.14),
                width: screenWidth(
                  context,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(1),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(1999, 07, 10),
                  lastDay: DateTime.utc(2200, 4, 28),
                  focusedDay: focusedDay,
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format){
                    setState(() {
                      format=_format;
                    });
                  },
                  onDaySelected: (DateTime selectDay, DateTime focusDay){
                    setState(() {
                      selectedDay= selectDay;
                      focusedDay=focusDay;
                    });
                  },
                  selectedDayPredicate: (DateTime date){
                    return isSameDay(selectedDay, date);
                  },

                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.white
                    ),
                    todayDecoration: BoxDecoration(
                        color: Color(0xffff453a),
                        shape: BoxShape.circle
                    ),
                  ),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

