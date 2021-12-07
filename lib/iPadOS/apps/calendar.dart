import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:provider/provider.dart';
import '../../sizes.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {
  const Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.utc(1999, 07, 10);
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var calendarOpen = Provider.of<OnOff>(context).getCalendar;
    return Visibility(
      visible: calendarOpen,
      child: calendarWindow(context),
    );
  }

  Widget calendarWindow(BuildContext context) {
    var scale= Provider.of<DataBus>(context).getScale;
    return Transform.scale(
      scale: scale,
      alignment: Alignment.topCenter,
      child: Container(
        width: screenWidth(context, ),
        height: screenHeight(context, ),
        decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight(context, mulBy: 0.04),
            ),
            Expanded(
              child: TableCalendar(
                firstDay: DateTime.utc(1999, 07, 10),
                lastDay: DateTime.utc(2200, 4, 28),
                shouldFillViewport: true,
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
          ],
        ),
      ),
    );
  }
}
