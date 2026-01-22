import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreening extends StatefulWidget {
  const CalendarScreening({super.key});

  @override
  State<CalendarScreening> createState() => _CalendarScreeningState();
}

class _CalendarScreeningState extends State<CalendarScreening> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // tanggal -> jumlah screening
  Map<DateTime, int> screeningPerDay = {};

  @override
  void initState() {
    super.initState();
    _loadCalendarData();
  }

  Future<void> _loadCalendarData() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('screening_history') ?? [];

    Map<DateTime, int> temp = {};

    for (var item in history) {
      final data = jsonDecode(item);
      final date = DateTime.parse(data['date']);

      final key = DateTime(date.year, date.month, date.day);
      temp[key] = (temp[key] ?? 0) + 1;
    }

    setState(() {
      screeningPerDay = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kalender Screening',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TableCalendar(
              firstDay: DateTime(2024),
              lastDay: DateTime(2030),
              focusedDay: _focusedDay,

              selectedDayPredicate: (day) =>
                  isSameDay(_selectedDay, day),

              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },

              calendarBuilders: CalendarBuilders(
                /// 🔢 JUMLAH SCREENING PER HARI
                markerBuilder: (context, day, events) {
                  final key = DateTime(day.year, day.month, day.day);
                  final count = screeningPerDay[key] ?? 0;

                  if (count > 0) {
                    return Positioned(
                      bottom: 4,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(241, 67, 198, 1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },

                /// 🟩 BLOK TANGGAL LAMPAU JIKA SUDAH SCREENING
                defaultBuilder: (context, day, focusedDay) {
                  final key = DateTime(day.year, day.month, day.day);
                  final isPast =
                      day.isBefore(DateTime.now());
                  final hasScreening =
                      (screeningPerDay[key] ?? 0) > 0;

                  if (isPast && hasScreening) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
