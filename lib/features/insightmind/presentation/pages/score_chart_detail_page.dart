import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class ScoreChartDetailPage extends StatelessWidget {
  const ScoreChartDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Grafik Screening'),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final prefs = snapshot.data!;
          final data = prefs.getStringList('screening_history') ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text('Belum ada data screening'),
            );
          }

          final spots = <FlSpot>[];

          for (int i = 0; i < data.length; i++) {
            final item = jsonDecode(data[i]) as Map<String, dynamic>;
            final score = (item['score'] as num).toDouble();
            spots.add(FlSpot(i.toDouble() + 1, score));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Perkembangan Skor Screening',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
