
import 'package:farda/components/_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScreenCalendar extends StatefulWidget {
  const ScreenCalendar({super.key});

  @override
  State<ScreenCalendar> createState() => _ScreenCalendarState();
}

class _ScreenCalendarState extends State<ScreenCalendar> {
  final calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      calendarController.setEvents({
        DateFormat('yyyy-MM-dd').format(DateTime.now()): [
          CalendarEvent(
            'Morning Dose',
            TimeOfDay(hour: 9, minute: 0),
            TimeOfDay(hour: 9, minute: 36),
            Colors.green,
          ),
          CalendarEvent(
            'Early Afternoon Dose',
            TimeOfDay(hour: 14, minute: 30),
            TimeOfDay(hour: 15, minute: 0),
            Colors.orange,
          ),
          CalendarEvent(
            'Evening Dose',
            TimeOfDay(hour: 18, minute: 0),
            TimeOfDay(hour: 19, minute: 15),
            Colors.red,
          ),
          CalendarEvent(
            'Mid Night Dose',
            TimeOfDay(hour: 23, minute: 0),
            TimeOfDay(hour: 23, minute: 10),
            Colors.yellow,
          ),
        ],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: CustomCalendarView(controller: calendarController)),
    );
  }
}
