import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:provider/provider.dart';
import '../openApps.dart';
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
  DateTime selectedDay = DateTime.utc(1999, 07, 10);
  DateTime focusedDay = DateTime.now();

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
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: calendarFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.7),
      height: calendarFS
          ?screenHeight(context, mulBy: 0.966)
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
      child: Stack(
        children: [
          Column(
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
                                Provider.of<Apps>(context, listen: false).closeApp("calendar");
                                Provider.of<OnOff>(context, listen: false)
                                    .offCalendarFS();
                                Provider.of<OnOff>(context, listen: false).toggleCalendar();

                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              onTap: (){
                                Provider.of<OnOff>(context, listen: false).toggleCalendar();
                                Provider.of<OnOff>(context, listen: false).offCalendarFS();
                              },
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
                      bottomRight: Radius.circular(10)),
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
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        todayDecoration: BoxDecoration(
                            color: Color(0xffff453a), shape: BoxShape.circle),
                        defaultTextStyle: TextStyle(
                            color: Theme.of(context).cardColor.withOpacity(1),
                            fontWeight:
                                Theme.of(context).textTheme.headline4.fontWeight,
                            fontFamily: "HN"),
                        weekendTextStyle: TextStyle(
                            color: Theme.of(context).cardColor.withOpacity(0.6),
                            fontWeight:
                                Theme.of(context).textTheme.headline4.fontWeight,
                            fontFamily: "HN"),
                        outsideTextStyle: TextStyle(
                            color: Theme.of(context).cardColor.withOpacity(0.3),
                            fontWeight:
                                Theme.of(context).textTheme.headline4.fontWeight,
                            fontFamily: "HN"),

                      ),
                     // rowHeight: screenHeight(context, mulBy: 0.07  ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                      ),
                      calendarBuilders:
                          CalendarBuilders(
                            headerTitleBuilder: (context, dateTime) {
                        return Row(
                          children: [
                            Text(
                              "${DateFormat("LLLL").format(dateTime)}",
                              style: TextStyle(
                                  color: Theme.of(context).cardColor.withOpacity(1),
                                  fontWeight: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .fontWeight,
                                  fontSize: 25,
                                  fontFamily: "HN"),
                            ),
                            Text(
                              " ${DateFormat("y").format(dateTime)}",
                              style: TextStyle(
                                  color: Theme.of(context).cardColor.withOpacity(1),
                                  fontWeight: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .fontWeight,
                                  fontSize: 25,
                                  fontFamily: "HN"),
                            ),
                          ],
                        );
                      },
                              defaultBuilder: (context, dateTime, event) {
                        return Container(
                          decoration: BoxDecoration(
                              color: (dateTime.weekday==DateTime.sunday)?Theme.of(context).cardColor.withOpacity(0.08):Colors.transparent,
                              border: Border.all(
                                  color:
                                      Theme.of(context).cardColor.withOpacity(0.5),
                                  width: 0.1)),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                padding: EdgeInsets.all(6),
                              child: Text(
                                (dateTime.day==1)?"${DateFormat("d LLL").format(dateTime)}":"${DateFormat("d").format(dateTime)}",
                                style: TextStyle(
                                    color: Theme.of(context).cardColor.withOpacity(1),
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .fontWeight,
                                    fontSize: 14,
                                    fontFamily: "HN"),
                              ),
                            ),
                          ),
                        );
                      },
                            todayBuilder: (context, dateTime, event) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: (dateTime.weekday==DateTime.sunday)?Theme.of(context).cardColor.withOpacity(0.08):Colors.transparent,
                                    border: Border.all(
                                        color:
                                        Theme.of(context).cardColor.withOpacity(0.5),
                                        width: 0.1)),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Color(0xffff453a),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                          "${DateFormat("d").format(dateTime)}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                .fontWeight,
                                            fontSize: 12.5,
                                            fontFamily: "HN"),
                                      ),
                                    ),
                                  ),
                                )
                              );
                            },
                            selectedBuilder: (context, dateTime, event) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: (dateTime.weekday==DateTime.sunday)?Theme.of(context).cardColor.withOpacity(0.08):Colors.transparent,

                                    border: Border.all(
                                        color:
                                        Theme.of(context).cardColor.withOpacity(0.5),
                                        width: 0.1)),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${DateFormat("d").format(dateTime)}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                .fontWeight,
                                            fontSize: 12.5,
                                            fontFamily: "HN"),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            outsideBuilder: (context, dateTime, event) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: (dateTime.weekday==DateTime.sunday)?Theme.of(context).cardColor.withOpacity(0.08):Colors.transparent,
                                    border: Border.all(
                                        color:
                                        Theme.of(context).cardColor.withOpacity(0.5),
                                        width: 0.1)),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    child: Text(
                                      (dateTime==1)?"${DateFormat("d LLL").format(dateTime)}": "${DateFormat("d").format(dateTime)}",
                                      style: TextStyle(
                                          color: Theme.of(context).cardColor.withOpacity(0.3),
                                          fontWeight: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              .fontWeight,
                                          fontSize: 14,
                                          fontFamily: "HN"),
                                    ),
                                  ),
                                ),
                              );
                            },
                            dowBuilder: (context, dateTime){
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  "${DateFormat("E").format(dateTime)}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Theme.of(context).cardColor.withOpacity(1),
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .fontWeight,
                                      fontSize: 14,
                                      fontFamily: "HN"),
                                ),
                              );
                            },

                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),


    Visibility(
      visible: topApp != "Calendar",
      child: InkWell(
        onTap: (){
          Provider.of<Apps>(context, listen: false)
              .bringToTop(ObjectKey("calendar"));
        },
        child: Container(
          width: screenWidth(context,),
          height: screenHeight(context,),
          color: Colors.transparent,
        ),
      ),
    ),
        ],
      ),
    );
  }
}
