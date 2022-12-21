// ignore_for_file: prefer_const_constructors

import 'package:custom_calendar/global.dart';
import 'package:custom_calendar/utils/show_calendar_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<DateTime?> _noPresetDate = ValueNotifier(null);
  ValueNotifier<DateTime?> _fourPresetsDate = ValueNotifier(null);
  ValueNotifier<DateTime?> _sixPresetsDate = ValueNotifier(null);

  @override
  void dispose() {
    _noPresetDate.dispose();
    _fourPresetsDate.dispose();
    _sixPresetsDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Calendar widgets',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Without preset',
                        style: buttonStyle,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    _noPresetDate.value = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowCalendarDialog(
                            prevDate: _noPresetDate.value,
                          );
                        });
                  }),
            ),
            ValueListenableBuilder(
                valueListenable: _noPresetDate,
                builder: (BuildContext context, DateTime? date, Widget? child) {
                  return date != null
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  size: 20, color: Colors.blue),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                DateFormat('dd MMM yyyy').format(date),
                                style: dateStyle,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _noPresetDate.value = null;
                                  },
                                  child: Icon(Icons.close_rounded,
                                      size: 20, color: Colors.blue)),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 36,
                        );
                }),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'With 4 presets',
                        style: buttonStyle,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    _fourPresetsDate.value = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowCalendarDialog(
                            type: 'fourPresets',
                            prevDate: _fourPresetsDate.value,
                          );
                        });
                  }),
            ),
            ValueListenableBuilder(
                valueListenable: _fourPresetsDate,
                builder: (BuildContext context, DateTime? date, Widget? child) {
                  return date != null
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  size: 20, color: Colors.blue),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                date == DateTime(2100)
                                    ? 'Never ends'
                                    : DateFormat('dd MMM yyyy').format(date),
                                style: dateStyle,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _fourPresetsDate.value = null;
                                  },
                                  child: Icon(Icons.close_rounded,
                                      size: 20, color: Colors.blue)),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 36,
                        );
                }),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'With 6 presets',
                        style: buttonStyle,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    _sixPresetsDate.value = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowCalendarDialog(
                            type: 'sixPresets',
                            prevDate: _sixPresetsDate.value,
                          );
                        });
                  }),
            ),
            ValueListenableBuilder(
                valueListenable: _sixPresetsDate,
                builder: (BuildContext context, DateTime? date, Widget? child) {
                  return date != null
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  size: 20, color: Colors.blue),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                DateFormat('dd MMM yyyy').format(date),
                                style: dateStyle,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _sixPresetsDate.value = null;
                                  },
                                  child: Icon(Icons.close_rounded,
                                      size: 20, color: Colors.blue)),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 36,
                        );
                }),
          ],
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Rohan Ubhare',
              textAlign: TextAlign.center,
            ),
          ),
        )
      ]),
    );
  }
}
