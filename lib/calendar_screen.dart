import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'bottom_sheet_widget.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime startOfWeek = DateTime.now();
  DateTime endOfWeek = DateTime.now().add(Duration(days: 6));
  bool isDaySelected = true; // Track the selected mode
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<User> allUsers = [
    User(userId: "1", email: "user1@example.com", name: "User 1"),
    User(userId: "2", email: "user2@example.com", name: "User 2"),
    // Add more users as needed
  ];

  List<User> hdrUsers = [
    User(userId: "3", email: "hdr1@example.com", name: "HDR User 1"),
    User(userId: "4", email: "hdr2@example.com", name: "HDR User 2"),
    // Add more users as needed
  ];

  List<User> techUsers = [
    User(userId: "5", email: "tech1@example.com", name: "Tech User 1"),
    User(userId: "6", email: "tech2@example.com", name: "Tech User 2"),
    // Add more users as needed
  ];

  List<User> followUpUsers = [
    User(userId: "7", email: "followup1@example.com", name: "Follow Up User 1"),
    User(userId: "8", email: "followup2@example.com", name: "Follow Up User 2"),
    // Add more users as needed
  ];
  void _showBottomSheet(
      {required BuildContext context,
      required bool isSingleDaySelected,
      DateTime? startDate,
      DateTime? endDate}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyBottomSheet(isSingleDaySelected, startDate, endDate);
      },
    );
  }

  Widget _buildCustomButton({
    required String text,
    required Function() onPressed,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: isSelected ? Colors.blue : Colors.white),
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              color: isSelected ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDayView() {
    return TableCalendar(
      currentDay: selectedDay,
      focusedDay: selectedDay,
      firstDay: DateTime(2000),
      lastDay: DateTime(2101),
      calendarFormat: CalendarFormat.values.first,
      onDaySelected: (DateTime day, DateTime focusedDay) {
        setState(() {
          selectedDay = day;
        });
        _showBottomSheet(
          context: context,
          isSingleDaySelected: true,
          startDate: day,
          endDate: null,
        );
      },
    );
  }

  Widget _buildWeekView() {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null; // Important to clean those
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _focusedDay = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;

          // Check if both start and end dates are selected, then show the bottom sheet
          if (_rangeStart != null && _rangeEnd != null) {
            _showBottomSheet(
              context: context,
              isSingleDaySelected: false,
              startDate: start,
              endDate: end,
            );
          }
        });
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Text("My Calendar")),
            _buildCustomButton(
              text: 'Day',
              onPressed: () {
                setState(() {
                  isDaySelected = true;
                });
              },
              isSelected: isDaySelected,
            ),
            _buildCustomButton(
              text: 'Week',
              onPressed: () {
                setState(() {
                  isDaySelected = false;
                });
              },
              isSelected: !isDaySelected,
            ),
          ],
        ),
      ),
      body: isDaySelected ? _buildDayView() : _buildWeekView(),
    );
  }
}

// Rest of the code remains unchanged

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
}..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
