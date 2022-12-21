// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowCalendarDialog extends StatefulWidget {
  final type;
  final prevDate;

  const ShowCalendarDialog({Key? key, this.type, this.prevDate})
      : super(key: key);

  @override
  State<ShowCalendarDialog> createState() => _ShowCalendarDialogState();
}

class _ShowCalendarDialogState extends State<ShowCalendarDialog> {
  ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  ValueNotifier<DateTime?> _selectedDay = ValueNotifier(null);
  ValueNotifier<String?> _presetsVal = ValueNotifier(null);

  List fourPresetsName = [
    'Never ends',
    '15 days later',
    '30 days later',
    '60 days later'
  ];

  List sixPresetsName = [
    'Yesterday',
    'Today',
    'Tomorrow',
    'This Saturday',
    'This Sunday',
    'Next Tuesday'
  ];

  late PageController pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    _presetsVal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ValueListenableBuilder(
                  valueListenable: _presetsVal,
                  builder: (BuildContext context, String? val, Widget? child) {
                    return Column(
                      children: <Widget>[
                        widget.type == 'fourPresets'
                            ? GridView.builder(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 32,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16),
                                itemCount: fourPresetsName.length,
                                itemBuilder: (BuildContext context, index) {
                                  return PresetButton(fourPresetsName[index]);
                                })
                            : widget.type == 'sixPresets'
                                ? GridView.builder(
                                    padding: EdgeInsets.only(top: 8),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: 32,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16),
                                    itemCount: sixPresetsName.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return PresetButton(
                                          sixPresetsName[index]);
                                    })
                                : SizedBox(),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    splashRadius: 1,
                    iconSize: 32,
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    icon: Icon(Icons.arrow_left, color: Colors.grey[600]),
                  ),
                  ValueListenableBuilder(
                      valueListenable: _focusedDay,
                      builder: (BuildContext context, DateTime? focusedDay,
                          Widget? child) {
                        return Text(
                          DateFormat.yMMMM().format(focusedDay!),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                  IconButton(
                    splashRadius: 10,
                    iconSize: 32,
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    icon: Icon(Icons.arrow_right, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: _selectedDay,
                builder: (BuildContext context, DateTime? selectedDay,
                    Widget? child) {
                  return TableCalendar(
                    // context: context,
                    rowHeight: 48,
                    focusedDay: _focusedDay.value,
                    firstDay: DateTime(1970),
                    lastDay: DateTime(2100),
                    headerVisible: false,
                    onCalendarCreated: (controller) =>
                        pageController = controller,
                    calendarStyle: CalendarStyle(
                      cellMargin: EdgeInsets.all(10),
                      todayTextStyle:
                          TextStyle(color: Colors.blue, fontSize: 16.0),
                      todayDecoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      selectedDecoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      _selectedDay.value = selectedDay;
                      _focusedDay.value = focusedDay;
                      _presetsVal.value = '';
                    },
                    onPageChanged: (focusedDay) =>
                        _focusedDay.value = focusedDay,
                  );
                }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.event_outlined, size: 24, color: Colors.blue),
                      SizedBox(
                        width: 6,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _selectedDay,
                          builder: (BuildContext context, DateTime? selectedDay,
                              Widget? child) {
                            return Text(
                              selectedDay != null
                                  ? DateFormat('dd MMM yyyy')
                                      .format(selectedDay)
                                  : '',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            );
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 36,
                        width: 68,
                        child: CupertinoButton(
                            color: Colors.blue[50],
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            borderRadius: BorderRadius.circular(6),
                            onPressed: (() =>
                                Navigator.pop(context, widget.prevDate)),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        height: 36,
                        width: 68,
                        child: CupertinoButton(
                          color: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          borderRadius: BorderRadius.circular(6),
                          onPressed: () {
                            Navigator.pop(context, _selectedDay.value);
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget PresetButton(String text) {
    return SizedBox(
      height: 32,
      child: TextButton(
        onPressed: () {
          _presetsVal.value = text;
          switch (text) {
            case 'Never ends':
              _focusedDay.value = DateTime.now();
              _selectedDay.value = null;
              break;

            case '15 days later':
              _focusedDay.value =
                  _selectedDay.value = DateTime.now().add(Duration(days: 15));
              break;

            case '30 days later':
              _focusedDay.value =
                  _selectedDay.value = DateTime.now().add(Duration(days: 30));
              break;

            case '60 days later':
              _focusedDay.value =
                  _selectedDay.value = DateTime.now().add(Duration(days: 60));
              break;

            case 'Yesterday':
              _focusedDay.value = _selectedDay.value =
                  DateTime.now().subtract(Duration(days: 1));
              break;

            case 'Today':
              _focusedDay.value = _selectedDay.value = DateTime.now();
              break;

            case 'Tomorrow':
              _focusedDay.value =
                  _selectedDay.value = DateTime.now().add(Duration(days: 1));
              break;

            case 'This Saturday':
              _focusedDay.value =
                  _selectedDay.value = DateTime.now().coming(DateTime.saturday);
              break;

            case 'This Sunday':
              _focusedDay.value =
                  _selectedDay.value = DateTime.now().coming(DateTime.sunday);
              break;

            case 'Next Tuesday':
              _focusedDay.value =
                  _selectedDay.value = DateTime.now().next(DateTime.tuesday);
              break;
          }
        },
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor:
              (_presetsVal.value == text) ? Colors.blue : Colors.blue.shade50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: (_presetsVal.value == text) ? Colors.white : Colors.blue,
          ),
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime coming(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }

  DateTime next(int day) {
    return add(
      Duration(
        days: 7 + ((day - weekday) % DateTime.daysPerWeek),
      ),
    );
  }
}
