import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var initDate = DateTime.now();
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: initDate,
      onSelectionChanged: (calendarSelectionDetails) {
        print("objet");
      },
      cellBorderColor: Colors.transparent,
      //todayHighlightColor: Colors.red,
    );
  }
}